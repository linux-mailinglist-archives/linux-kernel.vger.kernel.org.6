Return-Path: <linux-kernel+bounces-215786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F31909096F5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 10:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 716DE1F214EC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 08:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49C118EB8;
	Sat, 15 Jun 2024 08:25:13 +0000 (UTC)
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E8DBE68;
	Sat, 15 Jun 2024 08:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718439913; cv=none; b=QEYuKbQU+WYrUUoZN49NQvj9PyEWWnQc9lm3FtFHG5i219/bAXrILDKEupbej2wQzEy5NDA6ySOkkO3GUeXdITMSb2F32choLuuvhN5dpI24RNjjlSH7uSCiMXzs4Dym96sMrdOR6uC2VJRHexe5wW1Ez0PNzJTm1HuatpC1Lpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718439913; c=relaxed/simple;
	bh=IlnUBEHlUTDilPI8TWHODx0HU1aDoU75blv08V81wVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MSefItI7UXAFNaJfJ22Gi+VrIVhmu2K48iRsJURAAcCUQRS0osuWSgQ1KXemT+UAo8r0dMCRu/UVQ21YOkiOv9KLQDsSXzcGZ8fDQ3gv9q66ZAmpYzJav9Y339ARYEFdwLYSCIuDSGKodJ1I5sL/3tcpLdHnMqUh2cJqq4/SALE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app1 (Coremail) with SMTP id HgEQrADn74O_T21mNNvrBw--.52314S2;
	Sat, 15 Jun 2024 16:24:31 +0800 (CST)
Received: from [10.12.169.238] (unknown [10.12.169.238])
	by gateway (Coremail) with SMTP id _____wAHZi67T21mDCUdAQ--.56296S2;
	Sat, 15 Jun 2024 16:24:29 +0800 (CST)
Message-ID: <5351308d-6fb7-4179-b0a0-32107d8244b7@hust.edu.cn>
Date: Sat, 15 Jun 2024 16:24:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] doc-guide: add help documentation
 checktransupdate.rst
To: si.yanteng@linux.dev, Jonathan Corbet <corbet@lwn.net>,
 Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240615035323.909650-1-dzm91@hust.edu.cn>
 <20240615035323.909650-2-dzm91@hust.edu.cn>
 <4da91d0b2a0dc580ffaa7c67ab1860c310387e10@linux.dev>
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <4da91d0b2a0dc580ffaa7c67ab1860c310387e10@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrADn74O_T21mNNvrBw--.52314S2
Authentication-Results: app1; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW3XFy7Cr1kCw1kCF48Gw48JFb_yoW3CF4Upa
	43GFWxJan2q345tr1Ig34jvrnIyF1xCa1jgr17Kw1vqrn0yrn7JF43tryFgrWkJryrAayU
	ZFWjyry7uryrZFDanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmYb7Iv0xC_tr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	1Y6r17M2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI
	12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxV
	W8Jr0_Cr1UMcIj6x8ErcxFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCF04k20x
	vE74AGY7Cv6cx26r4fZr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxUV9N3UUUUU
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 2024/6/15 15:57, si.yanteng@linux.dev wrote:
> 2024年6月15日 11:53, "Dongliang Mu" <dzm91@hust.edu.cn> 写到:
>
>
>
>> This commit adds help documents - Documentation/doc-guide/checktransupdate.rst
>>
>> and Documentation/translations/zh_CN/doc-guide/checktransupdate.rst
>>
>> for scripts/checktransupdate.py, including English and Chinese versions
>>
>> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
>>
>> ---
>>
>> v1->v2: fix some issues according to Randy
>>
>>   Documentation/doc-guide/checktransupdate.rst | 63 +++++++++++++++++++
>>
>>   Documentation/doc-guide/index.rst | 1 +
>>
>>   .../zh_CN/doc-guide/checktransupdate.rst | 62 ++++++++++++++++++
>>
>>   .../translations/zh_CN/doc-guide/index.rst | 1 +
>>
>>   4 files changed, 127 insertions(+)
>>
>>   create mode 100644 Documentation/doc-guide/checktransupdate.rst
>>
>>   create mode 100644 Documentation/translations/zh_CN/doc-guide/checktransupdate.rst
>>
>> diff --git a/Documentation/doc-guide/checktransupdate.rst b/Documentation/doc-guide/checktransupdate.rst
>>
>> new file mode 100644
>>
>> index 000000000000..4ece330882d6
>>
>> --- /dev/null
>>
>> +++ b/Documentation/doc-guide/checktransupdate.rst
>>
>> @@ -0,0 +1,63 @@
>>
>> +.. SPDX-License-Identifier: GPL-2.0
>>
>> +
>>
>> +Check translation update
>>
>> +==========================
> Let's get rid of unnecessary symbols.
>> +
>>
>> +This script helps track the translation status of the documentation in
>>
>> +different locales, i.e., whether the documentation is up-to-date with
>>
>> +the English counterpart.
>>
>> +
>>
>> +How it works
>>
>> +------------
>>
>> +
>>
>> +It uses ``git log`` command to track the latest English commit from the
>>
>> +translation commit (order by author date) and the latest English commits
>>
>> +from HEAD. If any differences occur, the file is considered as out-of-date,
>>
>> +then commits that need to be updated will be collected and reported.
>>
>> +
>>
>> +Features implemented
>>
>> +--------------------
>>
>> +
>>
>> +- check all files in a certain locale
>>
>> +- check a single file or a set of files
>>
>> +- provide options to change output format
>>
>> +
>>
>> +Usage
>>
>> +-----
>>
>> +
>>
>> +::
>>
>> +
>>
>> + checktransupdate.py [-h] [-l LOCALE] [--print-commits | --no-print-commits] [--print-updated-files | --no-print-updated-files] [--debug | --no-debug] [files ...]
>>
>> +
>>
>> +Options
>>
>> +~~~~~~~
>>
>> +
>>
>> +- ``-l``, ``--locale``: locale to check when file is not specified
>>
>> +- ``--[no-]print-commits``: whether to print commits between origin and
>>
>> + translation
>>
>> +- ``--[no-]print-updated-files``: whether to print files that do no
>>
>> + need to be updated
>>
>> +- ``files``: files to check, if this option is specified, the locale
>>
>> + option will be ignored.
>>
>> +
>>
>> +Samples
>>
>> +~~~~~~~
>>
>> +
>>
>> +- ``./scripts/checktransupdate.py -l zh_CN``
>>
>> + This will print all the files that need to be updated in the zh_CN locale.
>>
>> +- ``./scripts/checktransupdate.py Documentation/translations/zh_CN/process/coding-style.rst``
>>
>> + This will only print the status of the specified file.
>>
>> +
>>
>> +Then the output is something like:
>>
>> +
>>
>> +::
>>
>> +
>>
>> + Documentation/translations/zh_CN/process/coding-style.rst (2 commits)
>>
>> + commit 6813216bbdba ("Documentation: coding-style: ask function-like macros to evaluate parameters")
>>
>> + commit 185ea7676ef3 ("Documentation: coding-style: Update syntax highlighting for code-blocks")
>>
>> +
>>
>> +Features to be implemented
>>
>> +----------------------------
> ditto
>
>> +
>>
>> +- track the translation status of files that have no translation
>>
>> +- files can be a folder instead of only a file
>>
>> diff --git a/Documentation/doc-guide/index.rst b/Documentation/doc-guide/index.rst
>>
>> index 7c7d97784626..24d058faa75c 100644
>>
>> --- a/Documentation/doc-guide/index.rst
>>
>> +++ b/Documentation/doc-guide/index.rst
>>
>> @@ -12,6 +12,7 @@ How to write kernel documentation
>>
>>   parse-headers
>>
>>   contributing
>>
>>   maintainer-profile
>>
>> + checktransupdate
>>
>>   
>>
>>   .. only:: subproject and html
>>
>>   
>>
>> diff --git a/Documentation/translations/zh_CN/doc-guide/checktransupdate.rst b/Documentation/translations/zh_CN/doc-guide/checktransupdate.rst
>>
>> new file mode 100644
>>
>> index 000000000000..37c0bb518ab8
>>
>> --- /dev/null
>>
>> +++ b/Documentation/translations/zh_CN/doc-guide/checktransupdate.rst
>>
>> @@ -0,0 +1,62 @@
>>
>> +.. SPDX-License-Identifier: GPL-2.0
>>
>> +
>>
>> +.. include:: ../disclaimer-zh_CN.rst
>>
>> +
>>
>> +:Original: Documentation/doc-guide/checktransupdate.rst
>>
>> +
>>
>> +:译者: 慕冬亮 Dongliang Mu <dzm91@hust.edu.cn>
>>
>> +
>>
>> +检查翻译更新
>>
>> +=============
> ditto
>> +
>>
>> +这个脚本帮助跟踪不同语言的文档翻译状态，即文档是否与对应的英文版本保持更新。
>>
>> +
>>
>> +工作原理
>>
>> +------------
>>
>> +
>>
>> +它使用 ``git log`` 命令来跟踪翻译提交的最新英文提交（按作者日期排序）和英文文档的
>>
>> +最新提交。如果有任何差异，则该文件被认为是过期的，然后需要更新的提交将被收集并报告。
>>
>> +
>>
>> +实现的功能
>>
>> +--------------------
> ditto
>
> ...
>
>> +
>>
>> +- 检查特定语言中的所有文件
>>
>> +- 检查单个文件或一组文件
>>
>> +- 提供更改输出格式的选项
>>
>> +
>>
>> +用法
>>
>> +-----
>>
>> +
>>
>> +::
>>
>> +
>>
>> + checktransupdate.py [-h] [-l LOCALE] [--print-commits | --no-print-commits] [--print-updated-files | --no-print-updated-files] [--debug | --no-debug] [files ...]
>>
>> +
>>
>> +选项
>>
>> +~~~~~~~
>>
>> +
>>
>> +- ``-l``, ``--locale``: 检查指定的文件语言，如果未指定文件
>>
>> +- ``--[no-]print-commits``: 是否打印英文原始版本和翻译版本之间的提交
>>
>> +- ``--[no-]print-updated-files``: 是否打印无需更新的文件
>>
>> +- ``files``: 要检查的文件，如果指定了此选项，将忽略语言选项
>>
>> +
>>
>> +示例
>>
>> +~~~~~~~
> ditto


Yanteng,

the requested changes does not match between English and Chinse translation.

Dongliang Mu


>
>
> Thanks,
> Yanteng
>> +
>>
>> +- ``./scripts/checktransupdate.py -l zh_CN``
>>
>> + 这将打印 zh_CN 语言中需要更新的所有文件。
>>
>> +- ``./scripts/checktransupdate.py Documentation/translations/zh_CN/process/coding-style.rst``
>>
>> + 这将只打印指定文件的状态。
>>
>> +
>>
>> +然后输出类似如下的内容：
>>
>> +
>>
>> +::
>>
>> +
>>
>> + Documentation/translations/zh_CN/process/coding-style.rst (2 commits)
>>
>> + commit 6813216bbdba ("Documentation: coding-style: ask function-like macros to evaluate parameters")
>>
>> + commit 185ea7676ef3 ("Documentation: coding-style: Update syntax highlighting for code-blocks")
>>
>> +
>>
>> +待实现的功能
>>
>> +-------------
>>
>> +
>>
>> +- 跟踪没有翻译过的文件的翻译状态
>>
>> +- 文件参数可以是文件夹而不仅仅是单个文件
>>
>> diff --git a/Documentation/translations/zh_CN/doc-guide/index.rst b/Documentation/translations/zh_CN/doc-guide/index.rst
>>
>> index 78c2e9a1697f..0ac1fc9315ea 100644
>>
>> --- a/Documentation/translations/zh_CN/doc-guide/index.rst
>>
>> +++ b/Documentation/translations/zh_CN/doc-guide/index.rst
>>
>> @@ -18,6 +18,7 @@
>>
>>   parse-headers
>>
>>   contributing
>>
>>   maintainer-profile
>>
>> + checktransupdate
>>
>>   
>>
>>   .. only:: subproject and html
>>
>>   
>>
>> -- 
>>
>> 2.39.2
>>


