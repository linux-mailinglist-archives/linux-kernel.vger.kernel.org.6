Return-Path: <linux-kernel+bounces-322342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1405097278A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 05:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B342840AC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 03:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29F61514DA;
	Tue, 10 Sep 2024 03:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="stYe1fd9"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F281EB27
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 03:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725938068; cv=none; b=MH71leaNoXs5G5O6+Dy/biSLFTFz+ogVszJB5XY0k9+WSszO1fmkLUwKV+T+Q6ubhP8GTNKQqN0J8EfndSOcHXn0iv76GLr/sQZu4U+SbVk5UEdbfK79Yl3p1Z9pcYRB9bcjB79JPMBuBV/uTZc14j4fnYq16EhmGnwU5JDDKkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725938068; c=relaxed/simple;
	bh=XZ/dizzuFlggz8N7mbiSBg50/BhHibOeNR0BlwyvmJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MiWt/YapgcniW4cOm70D0LU9kFPgdWOYn7JRcKles0n16l0cCOCzFmb/U5kSPsvsI9+E1pxyfVsqqm5qLW9YI4No+FW5BvAueE5YgTXABCxYlSU+Aa95Ac6fDAj1HwbjHz/uNdvsVTkaGCPLkFU8A7TKZ9fz7/ZAv6TVoto58Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=stYe1fd9; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <47e6a637-fe2c-4099-92bd-a2acdf1e0b3d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725938062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zOk3T4QNOS8F4QZutG3gxnZiBZHpX7piGLxJ1CtpCEI=;
	b=stYe1fd9ofOy2VXU90yQCIXm8JHOgjVG3QF0mCeO2ODlTQHK5LyDLEer8q5Gp568fdANa1
	CKGHBg0oGRRIZP49g1m6DHk4GFCXUmjQHUEFlF+xqFIJsjtgt3qmEiqbRPOd+qrG0Epj7D
	W+P315ubkSqRZMPHM7L8B7qUR1W0x2k=
Date: Tue, 10 Sep 2024 11:14:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] docs/zh_CN: add the translation of
 kbuild/gcc-plugins.rst
To: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>, Jonathan Corbet <corbet@lwn.net>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: hust-os-kernel-patches@googlegroups.cm, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20240907070244.206808-1-dzm91@hust.edu.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: YanTeng Si <si.yanteng@linux.dev>
In-Reply-To: <20240907070244.206808-1-dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




在 2024/9/7 15:02, Dongliang Mu 写道:
> Finish the translation of kbuild/gcc-plugins.rst and move gcc-plugins
> from TODO to the main body.
>
> Update to commit 3832d1fd84b6 ("docs/core-api: expand Fedora instructions
> for GCC plugins")
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
Reviewed-by: Yanteng Si <si.yanteng@linux.dev>


Thanks,
Yanteng
> ---
> v2->v3: fix sign incorrect pointed by Alex
> v1->v2: fix comments from yanteng
>   .../translations/zh_CN/kbuild/gcc-plugins.rst | 126 ++++++++++++++++++
>   .../translations/zh_CN/kbuild/index.rst       |   2 +-
>   2 files changed, 127 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/translations/zh_CN/kbuild/gcc-plugins.rst
>
> diff --git a/Documentation/translations/zh_CN/kbuild/gcc-plugins.rst b/Documentation/translations/zh_CN/kbuild/gcc-plugins.rst
> new file mode 100644
> index 000000000000..67a8abbf5887
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/kbuild/gcc-plugins.rst
> @@ -0,0 +1,126 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/kbuild/gcc-plugins.rst
> +:Translator: 慕冬亮 Dongliang Mu <dzm91@hust.edu.cn>
> +
> +================
> +GCC 插件基础设施
> +================
> +
> +
> +介绍
> +====
> +
> +GCC 插件是为编译器提供额外功能的可加载模块 [1]_。它们对于运行时插装和静态分析非常有用。
> +我们可以在编译过程中通过回调 [2]_，GIMPLE [3]_，IPA [4]_ 和 RTL Passes [5]_
> +（译者注：Pass 是编译器所采用的一种结构化技术，用于完成编译对象的分析、优化或转换等功能）
> +来分析、修改和添加更多的代码。
> +
> +内核的 GCC 插件基础设施支持构建树外模块、交叉编译和在单独的目录中构建。插件源文件必须由
> +C++ 编译器编译。
> +
> +目前 GCC 插件基础设施只支持一些架构。搜索 "select HAVE_GCC_PLUGINS" 来查找支持
> +GCC 插件的架构。
> +
> +这个基础设施是从 grsecurity [6]_  和 PaX [7]_ 移植过来的。
> +
> +--
> +
> +.. [1] https://gcc.gnu.org/onlinedocs/gccint/Plugins.html
> +.. [2] https://gcc.gnu.org/onlinedocs/gccint/Plugin-API.html#Plugin-API
> +.. [3] https://gcc.gnu.org/onlinedocs/gccint/GIMPLE.html
> +.. [4] https://gcc.gnu.org/onlinedocs/gccint/IPA.html
> +.. [5] https://gcc.gnu.org/onlinedocs/gccint/RTL.html
> +.. [6] https://grsecurity.net/
> +.. [7] https://pax.grsecurity.net/
> +
> +
> +目的
> +====
> +
> +GCC 插件的设计目的是提供一个用于试验 GCC 或 Clang 上游没有的潜在编译器功能的场所。
> +一旦它们的实用性得到验证，这些功能将被添加到 GCC（和 Clang）的上游。随后，在所有
> +支持的 GCC 版本都支持这些功能后，它们会被从内核中移除。
> +
> +具体来说，新插件应该只实现上游编译器（GCC 和 Clang）不支持的功能。
> +
> +当 Clang 中存在 GCC 中不存在的某项功能时，应努力将该功能做到 GCC 上游（而不仅仅
> +是作为内核专用的 GCC 插件），以使整个生态都能从中受益。
> +
> +类似的，如果 GCC 插件提供的功能在 Clang 中 **不** 存在，但该功能被证明是有用的，也应
> +努力将该功能上传到 GCC（和 Clang）。
> +
> +在上游 GCC 提供了某项功能后，该插件将无法在相应的 GCC 版本（以及更高版本）下编译。
> +一旦所有内核支持的 GCC 版本都提供了该功能，该插件将从内核中移除。
> +
> +
> +文件
> +====
> +
> +**$(src)/scripts/gcc-plugins**
> +
> +	这是 GCC 插件的目录。
> +
> +**$(src)/scripts/gcc-plugins/gcc-common.h**
> +
> +	这是 GCC 插件的兼容性头文件。
> +	应始终包含它，而不是单独的 GCC 头文件。
> +
> +**$(src)/scripts/gcc-plugins/gcc-generate-gimple-pass.h,
> +$(src)/scripts/gcc-plugins/gcc-generate-ipa-pass.h,
> +$(src)/scripts/gcc-plugins/gcc-generate-simple_ipa-pass.h,
> +$(src)/scripts/gcc-plugins/gcc-generate-rtl-pass.h**
> +
> +	这些头文件可以自动生成 GIMPLE、SIMPLE_IPA、IPA 和 RTL passes 的注册结构。
> +	与手动创建结构相比，它们更受欢迎。
> +
> +
> +用法
> +====
> +
> +你必须为你的 GCC 版本安装 GCC 插件头文件，以 Ubuntu 上的 gcc-10 为例::
> +
> +	apt-get install gcc-10-plugin-dev
> +
> +或者在 Fedora 上::
> +
> +	dnf install gcc-plugin-devel libmpc-devel
> +
> +或者在 Fedora 上使用包含插件的交叉编译器时::
> +
> +	dnf install libmpc-devel
> +
> +在内核配置中启用 GCC 插件基础设施与一些你想使用的插件::
> +
> +	CONFIG_GCC_PLUGINS=y
> +	CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y
> +	...
> +
> +运行 gcc（本地或交叉编译器），确保能够检测到插件头文件::
> +
> +	gcc -print-file-name=plugin
> +	CROSS_COMPILE=arm-linux-gnu- ${CROSS_COMPILE}gcc -print-file-name=plugin
> +
> +"plugin" 这个词意味着它们没有被检测到::
> +
> +	plugin
> +
> +完整的路径则表示插件已经被检测到::
> +
> +       /usr/lib/gcc/x86_64-redhat-linux/12/plugin
> +
> +编译包括插件在内的最小工具集::
> +
> +	make scripts
> +
> +或者直接在内核中运行 make，使用循环复杂性 GCC 插件编译整个内核。
> +
> +
> +4. 如何添加新的 GCC 插件
> +========================
> +
> +GCC 插件位于 scripts/gcc-plugins/。你需要将插件源文件放在 scripts/gcc-plugins/ 目录下。
> +子目录创建并不支持，你必须添加在 scripts/gcc-plugins/Makefile、scripts/Makefile.gcc-plugins
> +和相关的 Kconfig 文件中。
> diff --git a/Documentation/translations/zh_CN/kbuild/index.rst b/Documentation/translations/zh_CN/kbuild/index.rst
> index d906a4e88d0f..b51655d981f6 100644
> --- a/Documentation/translations/zh_CN/kbuild/index.rst
> +++ b/Documentation/translations/zh_CN/kbuild/index.rst
> @@ -13,6 +13,7 @@
>       :maxdepth: 1
>   
>       headers_install
> +    gcc-plugins
>   
>   TODO:
>   
> @@ -24,7 +25,6 @@ TODO:
>   - modules
>   - issues
>   - reproducible-builds
> -- gcc-plugins
>   - llvm
>   
>   .. only::  subproject and html


