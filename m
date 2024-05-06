Return-Path: <linux-kernel+bounces-170176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5238BD2DD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7B58B20D62
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01536156C60;
	Mon,  6 May 2024 16:31:01 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3298F5A;
	Mon,  6 May 2024 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715013060; cv=none; b=Ob+XC8+9neKtp+acjARAWjp+tcdP/HR+3WF3GQfUYUncLtuQ3quQl+N4siS8GnmVdm1xSglhK8HTMWxLoX5+sqr9GEA6W/j1JeYGVCquPypXBb/A90QtZqHlA7J8kFXCJ+FAuqU6+4uTF+8l7Q8UAabHNqK3ntVlD8rM8Pm8Tsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715013060; c=relaxed/simple;
	bh=623+yU0kR22zVSMp+4D0D9rwb5aiSdJGh/wAH4FIayI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CfTt0eJ+esKqKG3CCIHdnFD6/WBXoLq/9gpmYusvQSL+wvDzuPPMj7p6qeMzsmi9jLNg/k3pukaWXwQlJmoprQs7bpkHxwyjW2Z7QJjPb56GrKIjciwxvvCyf4Y7JMYMGL0qeJ40K9poVDG8MDiRmQBjDkKZglyKQ7aij8SdvMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id CDCFF12086E;
	Mon,  6 May 2024 16:11:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id 1A0BB20031;
	Mon,  6 May 2024 16:11:35 +0000 (UTC)
Message-ID: <0e0cf5fc8c78fac42f4c657421d16456a7adca7f.camel@perches.com>
Subject: Re: [PATCH RESEND v6 2/2] scripts: checkpatch: check unused
 parameters for function-like macro
From: Joe Perches <joe@perches.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, apw@canonical.com, broonie@kernel.org, 
 charlemagnelasse@gmail.com, chenhuacai@loongson.cn, chris@zankel.net, 
 corbet@lwn.net, dwaipayanray1@gmail.com, herbert@gondor.apana.org.au, 
 jcmvbkbc@gmail.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux@roeck-us.net, lukas.bulwahn@gmail.com,
 mac.xxn@outlook.com,  quic_jjohnson@quicinc.com, sfr@canb.auug.org.au,
 v-songbaohua@oppo.com,  workflows@vger.kernel.org
Date: Mon, 06 May 2024 09:11:35 -0700
In-Reply-To: <20240506071657.13434-1-21cnbao@gmail.com>
References: <5e26f82913801050afa4442dfb9a07249895ab98.camel@perches.com>
	 <20240506071657.13434-1-21cnbao@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 1A0BB20031
X-Stat-Signature: 3d6e4wb336qwmeni145jng3ns8dsimgg
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19zhs/AL5WOEbFEj5qxCA36b2fsPCGbK8Y=
X-HE-Tag: 1715011895-145619
X-HE-Meta: U2FsdGVkX1+UN2l/xe24BoxmZ2QcxLtMu707GVkFNbI4UaziYTworPj1CkmGHgewpzpU0bAt6CCktYhwbwv/1O70NRFkSHTWBE1TQcOiRalIqxAOHWVzyOejTQWInLHQwft499ZlkutiSDplRztuGJ5YYRBPSrIt3FIYzWDFmFJsTklteL996mLTidqKdoYot6Nh4FVfPIQQbQQA2b6zFGYO+cwYfGXljxWNxnfJow3F/kPlTApnHE1mt41bxlRwm8LIHOBCg23bkH50w17DODUU/9JZgw16ZmxjcZ1s9vcssLktRrVuRJSCz3hqur8Op/mn7OglbGf1aZ05cdKM/leHDc/Ty2IayAICLi/o/9rzZp3Sm/bs9YbuSsvkLEX6pWblgLYQzgM+y8O5kLa0xQ==

On Mon, 2024-05-06 at 19:16 +1200, Barry Song wrote:
> > > From: Xining Xu <mac.xxn@outlook.com>
> > >=20
> > > If function-like macros do not utilize a parameter, it might result i=
n a
> > > build warning.  In our coding style guidelines, we advocate for utili=
zing
> > > static inline functions to replace such macros.  This patch verifies
> > > compliance with the new rule.
> > []
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > []
> > > @@ -6040,6 +6040,12 @@ sub process {
> > > =A0					CHK("MACRO_ARG_PRECEDENCE",
> > > =A0					    "Macro argument '$arg' may be better as '($arg)' to avoid=
 precedence issues\n" . "$herectx");
> > > =A0				}
> > > +
> > > +# check if this is an unused argument
> > > +				if ($define_stmt !~ /\b$arg\b/) {
> > > +					WARN("MACRO_ARG_UNUSED",
> > > +						"Argument '$arg' is not used in function-like macro\n" . "$her=
ectx");
> >=20
> > trivia:  This should be aligned to the open parenthesis.
> >=20
>=20
> Hi Joe,
> I assume you mean the below?
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 9895d7e38a9f..2b812210b412 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -6044,7 +6044,7 @@ sub process {
> =A0# check if this is an unused argument
> =A0				if ($define_stmt !~ /\b$arg\b/) {
> =A0					WARN("MACRO_ARG_UNUSED",
> -						"Argument '$arg' is not used in function-like macro\n" . "$herectx=
");
> +					     "Argument '$arg' is not used in function-like macro\n" . "$her=
ectx");
> =A0				}
> =A0			}
> > Otherwise:
> > Acked-by: Joe Perches <joe@perches.com>

Yes, but please send a v7 instead of a separate patch
to akpm or perhaps Andrew could combine them or fix it
when applying v6


