#!/usr/bin/env pike

// Simple script sporting arguments parsing using Getopt.find_all_options()
// 
// Author(s): Bertrand LUPART


                             /* Global variables */

// Command line arguments
array arguments =
  ({
    ({ "help", Getopt.NO_ARG, ({ "-h" }) }),
    ({ "debug", Getopt.NO_ARG, ({ "-d" }) }),
    ({ "name", Getopt.HAS_ARG, ({ "-n", "--name" }) }),
  });

// Options parsed from arguments. Stored in a mapping for convenience
mapping options =
  ([
    "help" : 0,
    "debug" : 0,
    "name" : "",
  ]);

                            /* Script entry point*/

int main(int argc, array(string) argv)
{
  // first, parse arguments
  parse_arguments(argv);

	if(options->debug)
	{
		write("%O\n", options);
	}

	// In case we asked for help
	if(options->help==1)
	{
		usage(argv[0]);
		return 0;
	}

	// If user supplied his name
	if(sizeof(options->name))
	{
		write("Hello, %s!\n", options->name);
		return 0;
	}

	// Else, supply help
	usage(argv[0]);

  return 0;
}

//! Parse the command-line arguments, and feed the option mapping with them.
//!
//! @args argv
//!  The arguments passed to this script as an array(string)
//!
//! @returns
//!  Nothing

void parse_arguments(array(string) argv)
{
  array parsed_arguments = Getopt.find_all_options(argv, arguments, 0, 0);

	// store parsed arguments in a mapping for convenience
  foreach(parsed_arguments, array arg)
  {
    options[arg[0]]=arg[1];
  }

  return;
}

//! Display usage for script
//!
//! @args progname
//!  Name of the current script
//! 
//! @returns
//!  Nothing
void usage(string progname)
{
	write("Usage:\n");
	write("\t%s [-h] [-n name]\n", progname);
	write("\t%s [-h] [-n name]\n", progname);
	return;
}
