Return-Path: <linux-kernel+bounces-215129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E40908E72
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53FB1F27160
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0DD15FD08;
	Fri, 14 Jun 2024 15:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B98Kx3N8"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CCC61FE7;
	Fri, 14 Jun 2024 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718378033; cv=none; b=RP+htRELevwm1uNv1vWqeUSRqArUIy0Y1DsZONi0I5d9vGlhUxY09jJVlUbaP4H1A6fr0PEKEEclSc8+2T2Y9RXWrLQPlaroc13q5pDSgwkp73aoLuTD+aqGA4eX+tfDlSVtGh6DMl0QR12Jcoyq5XypP7gt3WpiAog+oGWQIX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718378033; c=relaxed/simple;
	bh=kdKKu//V/JDY1w85ohlNPYuN8+Zb6e4jCyerEC54//g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=co5RBr9HPH41qnw/qSck6yIjv8pYcKuDbdm41FXGcJ276v14jcIklTwD7ddYUZt11sxiAePWgjGh6TgS9UkN+EkSaxPLa2ys90Kp8+fvg+VKqyC67BihkA8MNXlk94oPfO9CPiuvoc7r+76/mOPaAu8+H0r84RrA9h1YfdvCVn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B98Kx3N8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=deIBNATut27wpMnCOaCssM9eor3bEzumeemqFygW8TY=; b=B98Kx3N8kXudY+xIUMWAuXyS34
	Cb3ySf95PPGJcL5tONbFUNUpyXzeLkbdV7B4OzImHpv9rnaezC/PRQzPlSEA5PABiEV1cl8VuccUA
	MC2Gv+5ZCES+ZOp6KczaeLlLKKZGyHfOAaPGQ+3b+76s4D/wHsZKlgERRFuvFphricZHkLA/HVgP4
	MWdvA7wiA1vHibSUOvHHzbx7EcwL1DOdvQUZynZ5p0xCOL24GHkcH04tf+w732TnhTmLkECB0yyd8
	qMY3TVSKEyl94B5OSfuYgJsfncOom5M9BqJQvwzIWxjGcPmhXCf9jwKCx62dvNpyickzbmv4GRHeP
	cXBWK6Rg==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI8cf-00000003C7i-2r4S;
	Fri, 14 Jun 2024 15:13:49 +0000
Message-ID: <36039474-367e-44d9-9cc5-54b327e5a8d9@infradead.org>
Date: Fri, 14 Jun 2024 08:13:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] doc-guide: add help documention checktransupdate.rst
To: Dongliang Mu <dzm91@hust.edu.cn>, Jonathan Corbet <corbet@lwn.net>,
 Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240614055328.778041-1-dzm91@hust.edu.cn>
 <20240614055328.778041-2-dzm91@hust.edu.cn>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240614055328.778041-2-dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix Subject: "documentation"

On 6/13/24 10:53 PM, Dongliang Mu wrote:
> This commit adds help documents - Documentation/doc-guide/checktransupdate.rst
> for scripts/checktransupdate.py, including English and Chinese versions
> 
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>  Documentation/doc-guide/checktransupdate.rst  | 63 +++++++++++++++++++
>  Documentation/doc-guide/index.rst             |  1 +
>  .../zh_CN/doc-guide/checktransupdate.rst      | 62 ++++++++++++++++++
>  .../translations/zh_CN/doc-guide/index.rst    |  1 +
>  4 files changed, 127 insertions(+)
>  create mode 100644 Documentation/doc-guide/checktransupdate.rst
>  create mode 100644 Documentation/translations/zh_CN/doc-guide/checktransupdate.rst
> 
> diff --git a/Documentation/doc-guide/checktransupdate.rst b/Documentation/doc-guide/checktransupdate.rst
> new file mode 100644
> index 000000000000..ec218c883b31
> --- /dev/null
> +++ b/Documentation/doc-guide/checktransupdate.rst
> @@ -0,0 +1,63 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Check translation update
> +==========================
> +
> +This script helps track the translation status of the documentation in
> +different locales, i.e., whether the documentation is update-to-date with

                                                         up-to-date with

> +the English conterpart.

               counterpart.

> +
> +How it works
> +------------
> +
> +It uses ``git log`` command to track the latest English commit from the
> +translation commit (order by author date) and the latest English commits
> +from HEAD. If any differences occur, the file is considered as out-of-date,
> +then commits that need to be updated will be collected and reported.
> +
> +Features implemented
> +--------------------
> +
> +-  check all files in a certain locale
> +-  check a single file or a set of files
> +-  provide options to change output format
> +
> +Usage
> +-----
> +
> +::
> +
> +   checktransupdate.py [-h] [-l LOCALE] [--print-commits | --no-print-commits] [--print-updated-files | --no-print-updated-files] [--debug | --no-debug] [files ...]
> +
> +Options
> +~~~~~~~
> +
> +-  ``-l``, ``--locale``: locale to check when file is not specified
> +-  ``--[no-]print-commits``: whether to print commits between origin and
> +   translation
> +-  ``--[no-]print-updated-files``: whether to print files that do no
> +   need to be updated
> +-  ``files``: files to check, if this option is specified, the locale
> +   option will be ignored.
> +
> +Samples
> +~~~~~~~
> +
> +-  ``./scripts/checktransupdate.py -l zh_CN``
> +   This will print all the files that need to be updated in the zh_CN locale.
> +-  ``./scripts/checktransupdate.py Documentation/translations/zh_CN/process/coding-style.rst``
> +   This will only print the status of the specified file.
> +
> +Then the output is something like:
> +
> +::
> +
> +    Documentation/translations/zh_CN/process/coding-style.rst       (2 commits)
> +    commit 6813216bbdba ("Documentation: coding-style: ask function-like macros to evaluate parameters")
> +    commit 185ea7676ef3 ("Documentation: coding-style: Update syntax highlighting for code-blocks")
> +
> +Features to be implemented
> +----------------------------
> +
> +- track the translation status of files that have no translation
> +- files can be a folder instead of only a file
> \ No newline at end of file

add a newline.

> diff --git a/Documentation/doc-guide/index.rst b/Documentation/doc-guide/index.rst
> index 7c7d97784626..24d058faa75c 100644
> --- a/Documentation/doc-guide/index.rst
> +++ b/Documentation/doc-guide/index.rst
> @@ -12,6 +12,7 @@ How to write kernel documentation
>     parse-headers
>     contributing
>     maintainer-profile
> +   checktransupdate
>  
>  .. only::  subproject and html
>  
> diff --git a/Documentation/translations/zh_CN/doc-guide/checktransupdate.rst b/Documentation/translations/zh_CN/doc-guide/checktransupdate.rst
> new file mode 100644
> index 000000000000..ce1165de1343
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/doc-guide/checktransupdate.rst
> @@ -0,0 +1,62 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/doc-guide/checktransupdate.rst
> +
> +:译者: 慕冬亮 Dongliang Mu <dzm91@hust.edu.cn>
> +
> +检查翻译更新
> +=============
> +
> +这个脚本帮助跟踪不同语言的文档翻译状态，即文档是否与对应的英文版本保持更新。
> +
> +工作原理
> +------------
> +
> +它使用 ``git log`` 命令来跟踪翻译提交的最新英文提交（按作者日期排序）和英文文档的
> +最新提交。如果有任何差异，则该文件被认为是过期的，然后需要更新的提交将被收集并报告。
> +
> +实现的功能
> +--------------------
> +
> +- 检查特定语言中的所有文件
> +- 检查单个文件或一组文件
> +- 提供更改输出格式的选项
> +
> +用法
> +-----
> +
> +::
> +
> +   checktransupdate.py [-h] [-l LOCALE] [--print-commits | --no-print-commits] [--print-updated-files | --no-print-updated-files] [--debug | --no-debug] [files ...]
> +
> +选项
> +~~~~~~~
> +
> +-  ``-l``, ``--locale``: 检查指定的文件语言，如果未指定文件
> +-  ``--[no-]print-commits``: 是否打印英文原始版本和翻译版本之间的提交
> +-  ``--[no-]print-updated-files``: 是否打印无需更新的文件
> +-  ``files``: 要检查的文件，如果指定了此选项，将忽略语言选项
> +
> +示例
> +~~~~~~~
> +
> +-  ``./scripts/checktransupdate.py -l zh_CN``
> +   这将打印 zh_CN 语言中需要更新的所有文件。
> +-  ``./scripts/checktransupdate.py Documentation/translations/zh_CN/process/coding-style.rst``
> +   这将只打印指定文件的状态。
> +
> +然后输出类似如下的内容：
> +
> +::
> +
> +    Documentation/translations/zh_CN/process/coding-style.rst       (2 commits)
> +    commit 6813216bbdba ("Documentation: coding-style: ask function-like macros to evaluate parameters")
> +    commit 185ea7676ef3 ("Documentation: coding-style: Update syntax highlighting for code-blocks")
> +
> +待实现的功能
> +-------------
> +
> +- 跟踪没有翻译过的文件的翻译状态
> +- 文件参数可以是文件夹而不仅仅是单个文件
> \ No newline at end of file

add a newline.

> diff --git a/Documentation/translations/zh_CN/doc-guide/index.rst b/Documentation/translations/zh_CN/doc-guide/index.rst
> index 78c2e9a1697f..0ac1fc9315ea 100644
> --- a/Documentation/translations/zh_CN/doc-guide/index.rst
> +++ b/Documentation/translations/zh_CN/doc-guide/index.rst
> @@ -18,6 +18,7 @@
>     parse-headers
>     contributing
>     maintainer-profile
> +   checktransupdate
>  
>  .. only::  subproject and html
>  

thanks.
-- 
~Randy

