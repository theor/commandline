// Copyright 2005-2013 Giacomo Stelluti Scala & Contributors. All rights reserved. See doc/License.md in the project root for license information.

namespace CommandLine.Tests.Fakes
{
    class FakeOptionsWithTwoIntegers
    {
        [Option('a')]
        public int A { get; set; }

        [Option('b')]
        public int B { get; set; }
    }
}