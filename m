Return-Path: <linux-kernel+bounces-169321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAA58BC707
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 07:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 192641C21193
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 05:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5744CB30;
	Mon,  6 May 2024 05:33:35 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203BB4779F;
	Mon,  6 May 2024 05:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973614; cv=none; b=fNEqgotFjvCUrQs7zrC01dHLkQdk3Ck0OP7tgQSMjeP6kU+qT0kQ+ayv728JEq0maRB2JmkmVqc7tm2IC6IpDskn9gQXFP8TCVCKtTT1dLcQ3ZoqxPiKuHtPfDt/8lGHtY+fvKsXrhm0qAQ5VqNHtHqlPIPPOP0a3eDBsLNr2OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973614; c=relaxed/simple;
	bh=du+ALvgKFi4Utr9m0V0kOjg/vAiXg0zO+2aWON7wKUk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G98YZQTnFLqp4Mdbqqdp3LZSypNW/71od3nV62DntOZPwWeJGrm38pGE471AqfR+rT2sBnbU9Q4//57TKkCqX4eGYOauF4GyZwX5c3ILDd451+HB+PVM9ncbH+llVf6DULKlBuMTrpyC4nBr6YHKcwgE/AASacDSqd3f6Gm1Mpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id D4F468059F;
	Mon,  6 May 2024 05:33:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id 3947020027;
	Mon,  6 May 2024 05:33:19 +0000 (UTC)
Message-ID: <5e26f82913801050afa4442dfb9a07249895ab98.camel@perches.com>
Subject: Re: [PATCH RESEND v6 2/2] scripts: checkpatch: check unused
 parameters for function-like macro
From: Joe Perches <joe@perches.com>
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, 
	linux-doc@vger.kernel.org
Cc: apw@canonical.com, broonie@kernel.org, chenhuacai@loongson.cn, 
 chris@zankel.net, corbet@lwn.net, dwaipayanray1@gmail.com, 
 herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
 linux@roeck-us.net,  lukas.bulwahn@gmail.com, mac.xxn@outlook.com,
 sfr@canb.auug.org.au,  v-songbaohua@oppo.com, workflows@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>,  Jeff Johnson
 <quic_jjohnson@quicinc.com>, Charlemagne Lasse <charlemagnelasse@gmail.com>
Date: Sun, 05 May 2024 22:33:18 -0700
In-Reply-To: <20240506014606.8638-3-21cnbao@gmail.com>
References: <20240506014606.8638-1-21cnbao@gmail.com>
	 <20240506014606.8638-3-21cnbao@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 3947020027
X-Stat-Signature: aargiw53xx4ngbwux9sg9mpkukr7qpmn
X-Rspamd-Server: rspamout07
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/ciNc0vA18o/tMotMqT2SUzxIzu6KuCyw=
X-HE-Tag: 1714973599-630367
X-HE-Meta: U2FsdGVkX1/JqiA/9sG38C80kL0WMT+Wa7HG6VkyYyFiZr2Xmzw9B2TJWcB+1g6q0me1a6639DMhWvjI1KPiPkUYeEqpvBOy8o6AVkTqVhkr2DA0h02dDpSt8YQdfntmWH3jbXzSiMILjBQnqtkX4/xEm6sz2JRWbUXjntie9i12CO0kKAsHtqo9DIfqDPdlkLQ48grgf2A6jcgVeul51D+1unwIEOpUQ67e/4oOAk/qjqdCI+6mdgQ+IjyMhW5Kj+JjFctAoP1sxECwVytbKSt/SS952cNbpCffu2n3UO2G1sw21Gp1QVMgTN6FF9mVf9hbCJbqRNwh1boqQBonOubnHFNc6z/Nf+qJ7d8u6XnaGb6i65gVD+gLL8rSipii4HWpQAhPuOh1/4pEEnzG0s6gkXCmoJREmgLMgV5nrKoMxWd6O6YxDw==

On Mon, 2024-05-06 at 13:46 +1200, Barry Song wrote:
> From: Xining Xu <mac.xxn@outlook.com>
>=20
> If function-like macros do not utilize a parameter, it might result in a
> build warning.  In our coding style guidelines, we advocate for utilizing
> static inline functions to replace such macros.  This patch verifies
> compliance with the new rule.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -6040,6 +6040,12 @@ sub process {
>  					CHK("MACRO_ARG_PRECEDENCE",
>  					    "Macro argument '$arg' may be better as '($arg)' to avoid prece=
dence issues\n" . "$herectx");
>  				}
> +
> +# check if this is an unused argument
> +				if ($define_stmt !~ /\b$arg\b/) {
> +					WARN("MACRO_ARG_UNUSED",
> +						"Argument '$arg' is not used in function-like macro\n" . "$herectx=
");

trivia:  This should be aligned to the open parenthesis.

Otherwise:
Acked-by: Joe Perches <joe@perches.com>


