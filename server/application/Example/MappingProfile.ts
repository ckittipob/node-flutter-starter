import 'automapper-ts';

const mapExample = (input: any, outputClass: any) => {
    automapper.createMap('example', 'exampleDto').convertToType(outputClass)
    .forMember('id',((opts: AutoMapperJs.IMemberConfigurationOptions) => {
        opts.mapFrom('_id')}))
    .forMember('file',((opts: AutoMapperJs.IMemberConfigurationOptions) => { 
        return (opts.sourceObject.file === "" 
                ? 'asset/noimage.jpg':opts.sourceObject.file)}));
    // act
    return automapper.map('example', 'exampleDto', input);
}

export {
    mapExample
}