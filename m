Return-Path: <linux-kernel+bounces-243628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCA3929889
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 16:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759671C2221E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 14:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126B528DD2;
	Sun,  7 Jul 2024 14:53:57 +0000 (UTC)
Received: from domac.alu.hr (domac.alu.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC0F224DD
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.235.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720364036; cv=none; b=Hfa14+KxwXrVcybPiI09KeyVBZrZwKswyl12CCCa9fc3XnXXhGYBpDlMKhy0e7YCN885QnQYn5qtXzOFgWYSmDngEUjzxnHrzcQjZG8zsm0IuDrNgeGhQjh0vW4JaGYkQrs8oIgnSTyJWs0l9KT8g0fVRivgLI2bdRS2vLAP9Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720364036; c=relaxed/simple;
	bh=M+SGXgjsfoR8TEqvrfmgc7MBRienEtHopgHjtJA/678=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NBN2EH4rLoq6hYVfcQH1ZMOitxQNymaa4qryUJgJ7GxHdg3cOu/ziJB3FbKuPT1v0krXT3zuawT57mZC4Bzlw5VzFwqMAnvjK2UC7kU0rBEhFuRaMN7U+TMfkV0XwNCFDN/+OgXGKycjwLdG6TBZRIJ8aBtiLrWcmetSJ9aFf/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=161.53.235.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 8C1EE6017E;
	Sun,  7 Jul 2024 16:53:51 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e_e-a6ribevo; Sun,  7 Jul 2024 16:53:49 +0200 (CEST)
Received: from [192.168.178.20] (dh207-40-28.xnet.hr [88.207.40.28])
	by domac.alu.hr (Postfix) with ESMTPSA id DEC556015E;
	Sun,  7 Jul 2024 16:53:39 +0200 (CEST)
Message-ID: <ada86a07-f19d-45f0-b839-21eb2395d41b@gmail.com>
Date: Sun, 7 Jul 2024 16:53:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPROBLEM_linux-next=5D_drivers/mtd/mtdpart=2Ec=3A?=
 =?UTF-8?B?NjkzOjM0OiBlcnJvcjog4oCYJXPigJkgZGlyZWN0aXZlIGFyZ3VtZW50IGlzIG51?=
 =?UTF-8?Q?ll?=
From: Mirsad Todorovac <mtodorovac69@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>
Cc: linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
 Miquel Raynal <miquel.raynal@bootlin.com>
References: <47e0483d-6e3d-43a8-9273-25278a4a74b9@gmail.com>
 <0c095098-4b3e-481b-b866-29cacb9f165d@milecki.pl>
 <CAOiHx=nmcf1mRy_i9vUDNtqOZTQ=PFWY8MGEV1FZfgt=GHqj5A@mail.gmail.com>
 <f9818a25-0604-49a8-af06-3dc7de006377@gmail.com>
Content-Language: en-US
In-Reply-To: <f9818a25-0604-49a8-af06-3dc7de006377@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 7/7/24 16:09, Mirsad Todorovac wrote:
> 
> 
> On 7/7/24 10:12, Jonas Gorski wrote:
>> On Sun, 7 Jul 2024 at 09:38, Rafał Miłecki <rafal@milecki.pl> wrote:
>>>
>>> Some more descriptive subject would be nice :)
>>>
>>>
>>> On 7.07.2024 02:10, Mirsad Todorovac wrote:
>>>> In file included from ./include/asm-generic/bug.h:22,
>>>>                   from ./arch/x86/include/asm/bug.h:87,
>>>>                   from ./include/linux/bug.h:5,
>>>>                   from ./include/linux/fortify-string.h:6,
>>>>                   from ./include/linux/string.h:374,
>>>>                   from ./arch/x86/include/asm/page_32.h:18,
>>>>                   from ./arch/x86/include/asm/page.h:14,
>>>>                   from ./arch/x86/include/asm/processor.h:20,
>>>>                   from ./arch/x86/include/asm/timex.h:5,
>>>>                   from ./include/linux/timex.h:67,
>>>>                   from ./include/linux/time32.h:13,
>>>>                   from ./include/linux/time.h:60,
>>>>                   from ./include/linux/stat.h:19,
>>>>                   from ./include/linux/module.h:13,
>>>>                   from drivers/mtd/mtdpart.c:10:
>>>> drivers/mtd/mtdpart.c: In function ‘parse_mtd_partitions’:
>>>> drivers/mtd/mtdpart.c:693:34: error: ‘%s’ directive argument is null [-Werror=format-overflow=]
>>>>    693 |                         pr_debug("%s: got parser %s\n", master->name,
>>>>        |                                  ^~~~~~~~~~~~~~~~~~~~~
>>>> ./include/linux/printk.h:376:21: note: in definition of macro ‘pr_fmt’
>>>>    376 | #define pr_fmt(fmt) fmt
>>>>        |                     ^~~
>>>> ./include/linux/dynamic_debug.h:248:9: note: in expansion of macro ‘__dynamic_func_call_cls’
>>>>    248 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
>>>>        |         ^~~~~~~~~~~~~~~~~~~~~~~
>>>> ./include/linux/dynamic_debug.h:250:9: note: in expansion of macro ‘_dynamic_func_call_cls’
>>>>    250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
>>>>        |         ^~~~~~~~~~~~~~~~~~~~~~
>>>> ./include/linux/dynamic_debug.h:269:9: note: in expansion of macro ‘_dynamic_func_call’
>>>>    269 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
>>>>        |         ^~~~~~~~~~~~~~~~~~
>>>> ./include/linux/printk.h:610:9: note: in expansion of macro ‘dynamic_pr_debug’
>>>>    610 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
>>>>        |         ^~~~~~~~~~~~~~~~
>>>> drivers/mtd/mtdpart.c:693:25: note: in expansion of macro ‘pr_debug’
>>>>    693 |                         pr_debug("%s: got parser %s\n", master->name,
>>>>        |                         ^~~~~~~~
>>>> drivers/mtd/mtdpart.c:693:50: note: format string is defined here
>>>>    693 |                         pr_debug("%s: got parser %s\n", master->name,
>>>>        |                                                  ^~
>>>>
>>>> Offending commit is 5b644aa012f67.
>>>
>>> Actually it goes back to 2015 to the commit 8e2c992b59fc ("mtd: mtdpart: add debug prints to partition parser.").
>>>
>>>
>>>> Proposed non-intrusive fix resolves the warning/error, but I could not test the code.
>>>> (I don't have the physical device.)
>>>>
>>>> -----------------><------------------------------------------
>>>> diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
>>>> index 6811a714349d..81665d67ed2d 100644
>>>> --- a/drivers/mtd/mtdpart.c
>>>> +++ b/drivers/mtd/mtdpart.c
>>>> @@ -691,7 +691,7 @@ int parse_mtd_partitions(struct mtd_info *master, const char *const *types,
>>>>                          if (!parser && !request_module("%s", *types))
>>>>                                  parser = mtd_part_parser_get(*types);
>>>>                          pr_debug("%s: got parser %s\n", master->name,
>>>> -                               parser ? parser->name : NULL);
>>>> +                               parser ? parser->name : "(null"));
>>>>                          if (!parser)
>>>>                                  continue;
>>>>                          ret = mtd_part_do_parse(parser, master, &pparts, data);
>>>>
>>>>
>>>> Hope this helps.
>>>
>>> I'd say it's simple enough to send patch without actual hw testing.
>>
>> Though the kernel's vsprintf will already handle NULL pointers and
>> print "(null)" [1], so I'm not sure if this is an actual improvement.
>>
>> The only way this can be NULL though is if the request_module()
>> failed, so maybe a proper error message would be better here instead
>> of an obscure "got parser (null)". You don't even know which type
>> wasn't available. E.g. pr_debug("%: no parser for type %s
>> available\n", master->name, *types).
> 
> Agreed. Your proposal is much more descriptive.
> 
> Will you do this patch or should I and put a Suggested-by: ?
> 
> However, I would sleep much better if this is tested on actual hw. :-/

Is this what you had in mind?

-----------------><----------------------------
diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index 6811a714349d..dd02690abf3a 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -690,8 +690,12 @@ int parse_mtd_partitions(struct mtd_info *master, const char *const *types,
                        parser = mtd_part_parser_get(*types);
                        if (!parser && !request_module("%s", *types))
                                parser = mtd_part_parser_get(*types);
-                       pr_debug("%s: got parser %s\n", master->name,
-                               parser ? parser->name : NULL);
+                       if (!parser)
+                               pr_debug("%s: no parser available for type %s\n",
+                                       master->name, *types);
+                       else
+                               pr_debug("%s: got parser %s\n", master->name,
+                                       parser->name);
                        if (!parser)
                                continue;
                        ret = mtd_part_do_parse(parser, master, &pparts, data);
--

Best regards,
Mirsad Todorovac

> Best regards,
> Mirsad Todorovac
> 
>> [1] https://elixir.bootlin.com/linux/latest/source/lib/vsprintf.c#L696
>>
>> Best Regards,
>> Jonas


