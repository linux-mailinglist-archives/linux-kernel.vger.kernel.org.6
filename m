Return-Path: <linux-kernel+bounces-257121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7110C937584
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 11:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9413B1C212A9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 09:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7C18002A;
	Fri, 19 Jul 2024 09:08:57 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D5C5CB8;
	Fri, 19 Jul 2024 09:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721380136; cv=none; b=uosfUL/hzqBvIx+7b0LO3EG3nvvT5Wr/bBvt+gzftAOV9k0kUjbLcwRsvPMesMFZj2krrG5sgQgkGAeNjywRuHNdbmdl+4MELHXh6qNyuLaVzIceJ6UcXORMPNNTSA9yPYbSrRyTzL5L521rPm9XhNWqWKN2x99/LeZL8453lSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721380136; c=relaxed/simple;
	bh=r5cY1yppFY3shBpkgwffbnp/mSOqABVJYk5H0+K8u5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NHVPBjFD26XgZ2P6X4+L17Jqpxv0C9R4LR+64vPilfCHRXSVYYcegeBLjXMM+Zu4wPMre4HmYuX+I/oKgjHgfGPIDjWsMGQJG699rsyDN/lj4ICKSNePr+VwfbmiVa7eSxUyLEOHvDDenwi3axLcIW58+9KveCyMDlNvpCdxxTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.130])
	by gateway (Coremail) with SMTP id _____8DxDesjLZpm2voAAA--.5013S3;
	Fri, 19 Jul 2024 17:08:51 +0800 (CST)
Received: from [192.168.100.8] (unknown [223.64.68.130])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxDMchLZpmrWZPAA--.46779S3;
	Fri, 19 Jul 2024 17:08:50 +0800 (CST)
Message-ID: <dc977d5d-da1d-4489-82bc-e027239e7992@loongson.cn>
Date: Fri, 19 Jul 2024 17:08:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] doc-guide: add help documentation
 checktransupdate.rst
To: Dongliang Mu <dzm91@hust.edu.cn>, chengziqiu@hust.edu.cn,
 Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240719041400.3909775-1-dzm91@hust.edu.cn>
 <20240719041400.3909775-3-dzm91@hust.edu.cn>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <20240719041400.3909775-3-dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxDMchLZpmrWZPAA--.46779S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Gw4xWw1UJFW5ZF48KF48GrX_yoW7tryDpa
	45KFyxG3Z7Kw1Yyw1fK34DCr15AFyxCa13KF17t3ZYvFs8tws7Kr43ta4rKrWDJrWrZayY
	vFWY9ry09rW0vacCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
	6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7IU8q2NtUUUUU==


在 2024/7/19 12:13, Dongliang Mu 写道:
> This commit adds help documents - doc-guide/checktransupdate.rst
> and zh_CN/doc-guide/checktransupdate.rst for scripts/checktransupdate.py
> , including English and Chinese versions
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
Reviewed-by: Yanteng Si <siyanteng@loongson.cn>


Thanks,

Yanteng
> ---
>   Documentation/doc-guide/checktransupdate.rst  | 53 ++++++++++++++++++
>   Documentation/doc-guide/index.rst             |  1 +
>   .../zh_CN/doc-guide/checktransupdate.rst      | 55 +++++++++++++++++++
>   .../translations/zh_CN/doc-guide/index.rst    |  1 +
>   4 files changed, 110 insertions(+)
>   create mode 100644 Documentation/doc-guide/checktransupdate.rst
>   create mode 100644 Documentation/translations/zh_CN/doc-guide/checktransupdate.rst
>
> diff --git a/Documentation/doc-guide/checktransupdate.rst b/Documentation/doc-guide/checktransupdate.rst
> new file mode 100644
> index 000000000000..dabbf9ecd187
> --- /dev/null
> +++ b/Documentation/doc-guide/checktransupdate.rst
> @@ -0,0 +1,53 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Check translation update
> +
> +This script helps track the translation status of the documentation in
> +different locales, i.e., whether the documentation is up-to-date with
> +the English counterpart.
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
> +
> +-  check all files in a certain locale
> +-  check a single file or a set of files
> +-  provide options to change output format
> +-  track the translation status of files that have no translation
> +
> +Usage
> +-----
> +
> +::
> +
> +   ./scripts/checktransupdate.py --help
> +
> +Please refer to the output of argument parser for usage details.
> +
> +Samples
> +
> +-  ``./scripts/checktransupdate.py -l zh_CN``
> +   This will print all the files that need to be updated in the zh_CN locale.
> +-  ``./scripts/checktransupdate.py Documentation/translations/zh_CN/dev-tools/testing-overview.rst``
> +   This will only print the status of the specified file.
> +
> +Then the output is something like:
> +
> +::
> +
> +    Documentation/dev-tools/kfence.rst
> +    No translation in the locale of zh_CN
> +
> +    Documentation/translations/zh_CN/dev-tools/testing-overview.rst
> +    commit 42fb9cfd5b18 ("Documentation: dev-tools: Add link to RV docs")
> +    1 commits needs resolving in total
> +
> +Features to be implemented
> +
> +- files can be a folder instead of only a file
> diff --git a/Documentation/doc-guide/index.rst b/Documentation/doc-guide/index.rst
> index 7c7d97784626..24d058faa75c 100644
> --- a/Documentation/doc-guide/index.rst
> +++ b/Documentation/doc-guide/index.rst
> @@ -12,6 +12,7 @@ How to write kernel documentation
>      parse-headers
>      contributing
>      maintainer-profile
> +   checktransupdate
>   
>   .. only::  subproject and html
>   
> diff --git a/Documentation/translations/zh_CN/doc-guide/checktransupdate.rst b/Documentation/translations/zh_CN/doc-guide/checktransupdate.rst
> new file mode 100644
> index 000000000000..d20b4ce66b9f
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/doc-guide/checktransupdate.rst
> @@ -0,0 +1,55 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/doc-guide/checktransupdate.rst
> +
> +:译者: 慕冬亮 Dongliang Mu <dzm91@hust.edu.cn>
> +
> +检查翻译更新
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
> +
> +- 检查特定语言中的所有文件
> +- 检查单个文件或一组文件
> +- 提供更改输出格式的选项
> +- 跟踪没有翻译过的文件的翻译状态
> +
> +用法
> +-----
> +
> +::
> +
> +    ./scripts/checktransupdate.py --help
> +
> +具体用法请参考参数解析器的输出
> +
> +示例
> +
> +-  ``./scripts/checktransupdate.py -l zh_CN``
> +   这将打印 zh_CN 语言中需要更新的所有文件。
> +-  ``./scripts/checktransupdate.py Documentation/translations/zh_CN/dev-tools/testing-overview.rst``
> +   这将只打印指定文件的状态。
> +
> +然后输出类似如下的内容：
> +
> +::
> +
> +    Documentation/dev-tools/kfence.rst
> +    No translation in the locale of zh_CN
> +
> +    Documentation/translations/zh_CN/dev-tools/testing-overview.rst
> +    commit 42fb9cfd5b18 ("Documentation: dev-tools: Add link to RV docs")
> +    1 commits needs resolving in total
> +
> +待实现的功能
> +
> +- 文件参数可以是文件夹而不仅仅是单个文件
> diff --git a/Documentation/translations/zh_CN/doc-guide/index.rst b/Documentation/translations/zh_CN/doc-guide/index.rst
> index 78c2e9a1697f..0ac1fc9315ea 100644
> --- a/Documentation/translations/zh_CN/doc-guide/index.rst
> +++ b/Documentation/translations/zh_CN/doc-guide/index.rst
> @@ -18,6 +18,7 @@
>      parse-headers
>      contributing
>      maintainer-profile
> +   checktransupdate
>   
>   .. only::  subproject and html
>   


