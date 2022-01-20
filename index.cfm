<cfscript>
    libs= directoryList('libs');
    ITextRenderer = createObject("java", "org.xhtmlrenderer.pdf.ITextRenderer", libs);
    BaseFont = createObject("java", "com.lowagie.text.pdf.BaseFont", libs);
    xhtml = '<!DOCTYPE html>
            <html>
            <head></head>
            <body>
                <span style="font-family:MingLiU;">abcd</span><br/>
                <span style="font-family:MingLiU;">細明體字型</span><br/>
                <span style="font-family:MingLiU;">1234</span><br/>
            </body>
            </html>';

    try {
        renderer = ITextRenderer.init();
        resolver = renderer.getFontResolver();

        useFontDir = true;
        fontembed = true;
        if(useFontDir){
            resolver.addFontDirectory(expandPath("fonts"),fontembed);
        }else{
            resolver.addFont(expandPath("fonts/MingLiU-01.ttf"), BaseFont.IDENTITY_H, fontembed);
        }
        renderer.setDocumentFromString(xhtml);
        renderer.layout();

        Response = GetPageContext().GetResponse();
        outputstream = Response.getOutputStream();
        Response.setHeader( "Content-type", "Application/pdf" );
        renderer.createPDF(outputstream, false);
        renderer.finishPDF();
        outputstream.close();
    }catch(any e){
        dump(e);abort;
    } finally {
    }
</cfscript>
