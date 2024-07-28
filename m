Return-Path: <linux-kernel+bounces-264575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF8A93E585
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 15:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BE5F1C20EA3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 13:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67353F9FB;
	Sun, 28 Jul 2024 13:18:55 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419821B86C2
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 13:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722172735; cv=none; b=u/4/dQarMCH8DAJEMsljtclV6S+77c8WyCB4MMVsgVDUx0nKzLrJxMIRvBn+r97QZjbW0RKRnY6YOyqVtRIP2xbLaUZzuaG0d3u5k3HubtoK4Yb5LlObkJ8PG21dtAJMXLg6iXd5fn4CKS5zA8BN/NnpUtY7/WZncK5Rz5NQ/WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722172735; c=relaxed/simple;
	bh=4n7BlQFvNPXtWW3eAjZuvpHz9cMZXEKyncS/gLZlVPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EEOnnhElTWekygIh1bKHt7B/MtTb/3ny4/co4F0J33DCEILQSRJE0Ndv8MEEGDqDoiUsCa+Ei2BabCq1E7fVjT9D/OyciUmsTSTi7B7IjgMO18aek009bI82jX4CKz/Ls1PGh5GoT3RqEAaiSmBgV4P7DuiFEDm5lfjhrdr353o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 46SDIoLn098749;
	Sun, 28 Jul 2024 22:18:50 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Sun, 28 Jul 2024 22:18:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 46SDIoTV098746
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 28 Jul 2024 22:18:50 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e57e3e18-4f40-462e-959a-f6a9f19b1fe9@I-love.SAKURA.ne.jp>
Date: Sun, 28 Jul 2024 22:18:50 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] security: tomoyo: Add default builtin-policy.h for
 default policy
To: Michal Marek <mmarek@suse.cz>, Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        llvm@lists.linux.dev, Marcos Paulo de Souza <mpdesouza@suse.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling
 <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>
References: <20240727-tomoyo-gen-file-v1-1-eb6439e837a1@suse.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20240727-tomoyo-gen-file-v1-1-eb6439e837a1@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello, Michal and Masahiro. What do you think on this proposal?

I guess that .gitignore needs to keep builtin-policy.h included, or
"git diff" will complain if builtin-policy.h was rebuilt due to
changes in policy/*.conf files.

Regarding having default security/tomoyo/builtin-policy.h , is there
a pitfall with modification time of security/tomoyo/builtin-policy.h
and files involved in generating security/tomoyo/builtin-policy.h ?

On 2024/07/28 9:51, Marcos Paulo de Souza wrote:
> When checking tomoyo code there is an include for a file that is not
> included on kernel-source since it's generated at build time, and the
> kernel-source uses git archive to create the tarball.
> 
> Having the source code referencing a file that is not included in the
> tarball can confuse tools that inspect/parse code, since the file is not
> there.
> 
> The builtin-policy.h added is generated from the same default policy
> that already exists on policy/ directory, so it doesn't break the
> current usage of that file.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
> Hello, I sent this patch because we saw some issues while running
> clang-extract[1] on tomoyo given CVE 2024-26622. Since clang-extract
> parses the C files it failed to find builtin-policy.h. As a bandaid, I
> had to add
> 	-DCONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING
> 
> to clang-extract (we feed the gcc arguments used to compile common.c got
> from compile_commands.json on kernel-source).
> 
> Per my tests it works with my patch, and I don't see why this would hurt
> to have builtin-policy.h on git, since it would regenerate the file if
> the policy scripts are changed.
> 
> Please let me know if I'm missing something here.
> 
> Thanks!
> 
> [1]: https://github.com/SUSE/clang-extract
> ---
>  security/tomoyo/.gitignore       |  1 -
>  security/tomoyo/builtin-policy.h | 13 +++++++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/security/tomoyo/.gitignore b/security/tomoyo/.gitignore
> index 9f300cdce362..85d086c6502d 100644
> --- a/security/tomoyo/.gitignore
> +++ b/security/tomoyo/.gitignore
> @@ -1,3 +1,2 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -builtin-policy.h
>  policy/*.conf
> diff --git a/security/tomoyo/builtin-policy.h b/security/tomoyo/builtin-policy.h
> new file mode 100644
> index 000000000000..781d35b3ccb3
> --- /dev/null
> +++ b/security/tomoyo/builtin-policy.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +static char tomoyo_builtin_profile[] __initdata =
> +	"";
> +static char tomoyo_builtin_exception_policy[] __initdata =
> +	"initialize_domain /sbin/modprobe from any\n"
> +	"initialize_domain /sbin/hotplug from any\n"
> +	"";
> +static char tomoyo_builtin_domain_policy[] __initdata =
> +	"";
> +static char tomoyo_builtin_manager[] __initdata =
> +	"";
> +static char tomoyo_builtin_stat[] __initdata =
> +	"";
> 
> ---
> base-commit: 910bfc26d16d07df5a2bfcbc63f0aa9d1397e2ef
> change-id: 20240727-tomoyo-gen-file-fcfc3a0c0f46
> 
> Best regards,


