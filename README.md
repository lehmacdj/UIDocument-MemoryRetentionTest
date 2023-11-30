# UIDocument Memory Retention Test
This project demonstrates that UIDocument must be closed in order to be deallocated.

## Reproduction Steps
1. In it's base form this project deallocates the Document correctly
2. Run the project on My Mac and click "Pick a document" selecting any file
3. Then click "Cover up"
4. Create a memory graph of the project
5. Observe that there is no instance of Document retained, you can verify this by searching MemoryRetention in the sidebar of the debug inspector for the Memory Graph. ![screenshot of xcode showing that Document isn't retained](/img/not_retained.png)
6. Now comment out `await wrapped.close()` in DocumentWrapper.
7. Repeat steps 2 through 4
8. Now observe that there is an instance of Document retained even though DocumentWrapper has been deallocated successfully. It is being retained by NSFileArbiterProxy which is part of the internals of UIDocument. ![screenshot of xcode showing that Document is retained](/img/retained.png)
