Return-Path: <linux-kernel+bounces-257120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 355AC937582
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 11:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57DB41C211F9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 09:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA18D7E782;
	Fri, 19 Jul 2024 09:08:32 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5565CB8;
	Fri, 19 Jul 2024 09:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721380112; cv=none; b=RoJc6W00fvXdvfaWjuM5m0azoSetYg5lBxTXgysfbpjqcW1UkhzgHHng6uFj1zjvBRB8Oa6oWsYlJzEMJhvr7riuv+zBwiQYlClMEk2aDH2X78/IFBB22C2UyL4BZIwAJUiCKvfUEnTpQsSe1zkQqSFPThkY4mF1c33S08kJlYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721380112; c=relaxed/simple;
	bh=He02kKzrsD2yBHhzq3uOUmA+8OIua1ghEBETXy8gKN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jSMP5htCwBZD8vMa2StY9+Kwrms91MO/sqVYb+bO8Q/+ZMZzXoRgAMQ6uMfuFUTHgrW+9slYdYldyCpAZM5jejmUeQYz4RgJWjzfiRkOpUAjkb4+6ykRi64TK5PVW9scQHvqSisJ1z6SbsvpwEexBfbESS2c1V4c9bxaGuWhgUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.130])
	by gateway (Coremail) with SMTP id _____8DxzOoBLZpmyPoAAA--.5075S3;
	Fri, 19 Jul 2024 17:08:17 +0800 (CST)
Received: from [192.168.100.8] (unknown [223.64.68.130])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxTcf_LJpmfGZPAA--.47895S3;
	Fri, 19 Jul 2024 17:08:15 +0800 (CST)
Message-ID: <e62835be-0f54-44f3-9a61-6b2ee1f2ec89@loongson.cn>
Date: Fri, 19 Jul 2024 17:08:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] scripts: fix all issues reported by pylint
To: Dongliang Mu <dzm91@hust.edu.cn>, chengziqiu@hust.edu.cn,
 Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240719041400.3909775-1-dzm91@hust.edu.cn>
 <20240719041400.3909775-2-dzm91@hust.edu.cn>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <20240719041400.3909775-2-dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxTcf_LJpmfGZPAA--.47895S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWfJF4DKF4kJr4UCw48Aw13Awc_yoWkAw1Upa
	4rGFn7ArW3AFyUJw1xJw4jvFyayr93JrWjqryjv3s7Ar4DKasagF42k34Sv3yxWr1fXFWa
	qFWYkryYvw1jk3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU=


在 2024/7/19 12:13, Dongliang Mu 写道:
> This patch 1) fixes all the issues (not most) reported by pylint,
> 2) add the functionability to tackle documents that need translation,
> 3) add logging to adjust the logging level and log file
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>

Reviewed-by: Yanteng Si <siyanteng@loongson.cn>


Thanks,

Yanteng

> ---
>   scripts/checktransupdate.py | 214 ++++++++++++++++++++++++------------
>   1 file changed, 141 insertions(+), 73 deletions(-)
>
> diff --git a/scripts/checktransupdate.py b/scripts/checktransupdate.py
> index 5a0fc99e3f93..578c3fecfdfd 100755
> --- a/scripts/checktransupdate.py
> +++ b/scripts/checktransupdate.py
> @@ -10,31 +10,28 @@ differences occur, report the file and commits that need to be updated.
>   
>   The usage is as follows:
>   - ./scripts/checktransupdate.py -l zh_CN
> -This will print all the files that need to be updated in the zh_CN locale.
> +This will print all the files that need to be updated or translated in the zh_CN locale.
>   - ./scripts/checktransupdate.py Documentation/translations/zh_CN/dev-tools/testing-overview.rst
>   This will only print the status of the specified file.
>   
>   The output is something like:
> -Documentation/translations/zh_CN/dev-tools/testing-overview.rst (1 commits)
> +Documentation/dev-tools/kfence.rst
> +No translation in the locale of zh_CN
> +
> +Documentation/translations/zh_CN/dev-tools/testing-overview.rst
>   commit 42fb9cfd5b18 ("Documentation: dev-tools: Add link to RV docs")
> +1 commits needs resolving in total
>   """
>   
>   import os
> -from argparse import ArgumentParser, BooleanOptionalAction
> +import time
> +import logging
> +from argparse import ArgumentParser, ArgumentTypeError, BooleanOptionalAction
>   from datetime import datetime
>   
> -flag_p_c = False
> -flag_p_uf = False
> -flag_debug = False
> -
> -
> -def dprint(*args, **kwargs):
> -    if flag_debug:
> -        print("[DEBUG] ", end="")
> -        print(*args, **kwargs)
> -
>   
>   def get_origin_path(file_path):
> +    """Get the origin path from the translation path"""
>       paths = file_path.split("/")
>       tidx = paths.index("translations")
>       opaths = paths[:tidx]
> @@ -43,17 +40,16 @@ def get_origin_path(file_path):
>   
>   
>   def get_latest_commit_from(file_path, commit):
> -    command = "git log --pretty=format:%H%n%aD%n%cD%n%n%B {} -1 -- {}".format(
> -        commit, file_path
> -    )
> -    dprint(command)
> +    """Get the latest commit from the specified commit for the specified file"""
> +    command = f"git log --pretty=format:%H%n%aD%n%cD%n%n%B {commit} -1 -- {file_path}"
> +    logging.debug(command)
>       pipe = os.popen(command)
>       result = pipe.read()
>       result = result.split("\n")
>       if len(result) <= 1:
>           return None
>   
> -    dprint("Result: {}".format(result[0]))
> +    logging.debug("Result: %s", result[0])
>   
>       return {
>           "hash": result[0],
> @@ -64,17 +60,19 @@ def get_latest_commit_from(file_path, commit):
>   
>   
>   def get_origin_from_trans(origin_path, t_from_head):
> +    """Get the latest origin commit from the translation commit"""
>       o_from_t = get_latest_commit_from(origin_path, t_from_head["hash"])
>       while o_from_t is not None and o_from_t["author_date"] > t_from_head["author_date"]:
>           o_from_t = get_latest_commit_from(origin_path, o_from_t["hash"] + "^")
>       if o_from_t is not None:
> -        dprint("tracked origin commit id: {}".format(o_from_t["hash"]))
> +        logging.debug("tracked origin commit id: %s", o_from_t["hash"])
>       return o_from_t
>   
>   
>   def get_commits_count_between(opath, commit1, commit2):
> -    command = "git log --pretty=format:%H {}...{} -- {}".format(commit1, commit2, opath)
> -    dprint(command)
> +    """Get the commits count between two commits for the specified file"""
> +    command = f"git log --pretty=format:%H {commit1}...{commit2} -- {opath}"
> +    logging.debug(command)
>       pipe = os.popen(command)
>       result = pipe.read().split("\n")
>       # filter out empty lines
> @@ -83,50 +81,120 @@ def get_commits_count_between(opath, commit1, commit2):
>   
>   
>   def pretty_output(commit):
> -    command = "git log --pretty='format:%h (\"%s\")' -1 {}".format(commit)
> -    dprint(command)
> +    """Pretty print the commit message"""
> +    command = f"git log --pretty='format:%h (\"%s\")' -1 {commit}"
> +    logging.debug(command)
>       pipe = os.popen(command)
>       return pipe.read()
>   
>   
> +def valid_commit(commit):
> +    """Check if the commit is valid or not"""
> +    msg = pretty_output(commit)
> +    return "Merge tag" not in msg
> +
>   def check_per_file(file_path):
> +    """Check the translation status for the specified file"""
>       opath = get_origin_path(file_path)
>   
>       if not os.path.isfile(opath):
> -        dprint("Error: Cannot find the origin path for {}".format(file_path))
> +        logging.error("Cannot find the origin path for {file_path}")
>           return
>   
>       o_from_head = get_latest_commit_from(opath, "HEAD")
>       t_from_head = get_latest_commit_from(file_path, "HEAD")
>   
>       if o_from_head is None or t_from_head is None:
> -        print("Error: Cannot find the latest commit for {}".format(file_path))
> +        logging.error("Cannot find the latest commit for %s", file_path)
>           return
>   
>       o_from_t = get_origin_from_trans(opath, t_from_head)
>   
>       if o_from_t is None:
> -        print("Error: Cannot find the latest origin commit for {}".format(file_path))
> +        logging.error("Error: Cannot find the latest origin commit for %s", file_path)
>           return
>   
>       if o_from_head["hash"] == o_from_t["hash"]:
> -        if flag_p_uf:
> -            print("No update needed for {}".format(file_path))
> -        return
> +        logging.debug("No update needed for %s", file_path)
>       else:
> -        print("{}".format(file_path), end="\t")
> +        logging.info(file_path)
>           commits = get_commits_count_between(
>               opath, o_from_t["hash"], o_from_head["hash"]
>           )
> -        print("({} commits)".format(len(commits)))
> -        if flag_p_c:
> -            for commit in commits:
> -                msg = pretty_output(commit)
> -                if "Merge tag" not in msg:
> -                    print("commit", msg)
> +        count = 0
> +        for commit in commits:
> +            if valid_commit(commit):
> +                logging.info("commit %s", pretty_output(commit))
> +                count += 1
> +        logging.info("%d commits needs resolving in total\n", count)
> +
> +
> +def valid_locales(locale):
> +    """Check if the locale is valid or not"""
> +    script_path = os.path.dirname(os.path.abspath(__file__))
> +    linux_path = os.path.join(script_path, "..")
> +    if not os.path.isdir(f"{linux_path}/Documentation/translations/{locale}"):
> +        raise ArgumentTypeError("Invalid locale: {locale}")
> +    return locale
> +
> +
> +def list_files_with_excluding_folders(folder, exclude_folders, include_suffix):
> +    """List all files with the specified suffix in the folder and its subfolders"""
> +    files = []
> +    stack = [folder]
> +
> +    while stack:
> +        pwd = stack.pop()
> +        # filter out the exclude folders
> +        if os.path.basename(pwd) in exclude_folders:
> +            continue
> +        # list all files and folders
> +        for item in os.listdir(pwd):
> +            ab_item = os.path.join(pwd, item)
> +            if os.path.isdir(ab_item):
> +                stack.append(ab_item)
> +            else:
> +                if ab_item.endswith(include_suffix):
> +                    files.append(ab_item)
> +
> +    return files
> +
> +
> +class DmesgFormatter(logging.Formatter):
> +    """Custom dmesg logging formatter"""
> +    def format(self, record):
> +        timestamp = time.time()
> +        formatted_time = f"[{timestamp:>10.6f}]"
> +        log_message = f"{formatted_time} {record.getMessage()}"
> +        return log_message
> +
> +
> +def config_logging(log_level, log_file="checktransupdate.log"):
> +    """configure logging based on the log level"""
> +    # set up the root logger
> +    logger = logging.getLogger()
> +    logger.setLevel(log_level)
> +
> +    # Create console handler
> +    console_handler = logging.StreamHandler()
> +    console_handler.setLevel(log_level)
> +
> +    # Create file handler
> +    file_handler = logging.FileHandler(log_file)
> +    file_handler.setLevel(log_level)
> +
> +    # Create formatter and add it to the handlers
> +    formatter = DmesgFormatter()
> +    console_handler.setFormatter(formatter)
> +    file_handler.setFormatter(formatter)
> +
> +    # Add the handler to the logger
> +    logger.addHandler(console_handler)
> +    logger.addHandler(file_handler)
>   
>   
>   def main():
> +    """Main function of the script"""
>       script_path = os.path.dirname(os.path.abspath(__file__))
>       linux_path = os.path.join(script_path, "..")
>   
> @@ -134,62 +202,62 @@ def main():
>       parser.add_argument(
>           "-l",
>           "--locale",
> +        default="zh_CN",
> +        type=valid_locales,
>           help="Locale to check when files are not specified",
>       )
> +
>       parser.add_argument(
> -        "--print-commits",
> +        "--print-missing-translations",
>           action=BooleanOptionalAction,
>           default=True,
> -        help="Print commits between the origin and the translation",
> +        help="Print files that do not have translations",
>       )
>   
>       parser.add_argument(
> -        "--print-updated-files",
> -        action=BooleanOptionalAction,
> -        default=False,
> -        help="Print files that do no need to be updated",
> -    )
> +        '--log',
> +        default='INFO',
> +        choices=['DEBUG', 'INFO', 'WARNING', 'ERROR', 'CRITICAL'],
> +        help='Set the logging level')
>   
>       parser.add_argument(
> -        "--debug",
> -        action=BooleanOptionalAction,
> -        help="Print debug information",
> -        default=False,
> -    )
> +        '--logfile',
> +        default='checktransupdate.log',
> +        help='Set the logging file (default: checktransupdate.log)')
>   
>       parser.add_argument(
>           "files", nargs="*", help="Files to check, if not specified, check all files"
>       )
>       args = parser.parse_args()
>   
> -    global flag_p_c, flag_p_uf, flag_debug
> -    flag_p_c = args.print_commits
> -    flag_p_uf = args.print_updated_files
> -    flag_debug = args.debug
> +    # Configure logging based on the --log argument
> +    log_level = getattr(logging, args.log.upper(), logging.INFO)
> +    config_logging(log_level)
>   
> -    # get files related to linux path
> +    # Get files related to linux path
>       files = args.files
>       if len(files) == 0:
> -        if args.locale is not None:
> -            files = (
> -                os.popen(
> -                    "find {}/Documentation/translations/{} -type f".format(
> -                        linux_path, args.locale
> -                    )
> -                )
> -                .read()
> -                .split("\n")
> -            )
> -        else:
> -            files = (
> -                os.popen(
> -                    "find {}/Documentation/translations -type f".format(linux_path)
> -                )
> -                .read()
> -                .split("\n")
> -            )
> -
> -    files = list(filter(lambda x: x != "", files))
> +        offical_files = list_files_with_excluding_folders(
> +            os.path.join(linux_path, "Documentation"), ["translations", "output"], "rst"
> +        )
> +
> +        for file in offical_files:
> +            # split the path into parts
> +            path_parts = file.split(os.sep)
> +            # find the index of the "Documentation" directory
> +            kindex = path_parts.index("Documentation")
> +            # insert the translations and locale after the Documentation directory
> +            new_path_parts = path_parts[:kindex + 1] + ["translations", args.locale] \
> +                           + path_parts[kindex + 1 :]
> +            # join the path parts back together
> +            new_file = os.sep.join(new_path_parts)
> +            if os.path.isfile(new_file):
> +                files.append(new_file)
> +            else:
> +                if args.print_missing_translations:
> +                    logging.info(os.path.relpath(os.path.abspath(file), linux_path))
> +                    logging.info("No translation in the locale of %s\n", args.locale)
> +
>       files = list(map(lambda x: os.path.relpath(os.path.abspath(x), linux_path), files))
>   
>       # cd to linux root directory


