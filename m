Return-Path: <linux-kernel+bounces-181657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 746B88C7F44
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 02:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 302A82838EE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 00:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EF0748E;
	Fri, 17 May 2024 00:37:47 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DA23D7A
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 00:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715906267; cv=none; b=bQ6DmKZ2zvKaVn9L3mvIbgUDzfMOKibHKiGSzSXLJAWnyvYWfVvEy2ODSh+Dte3Ed9EdJ56zDmplFDyr46iFB5GbWe7blmQD+EjQUsaFQviZMH2I6DCngFcnHwCHwp0ZRpnHwM3VOGfkPwGFS0W5U+Cuv+RffAbHbRTrLfsYnhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715906267; c=relaxed/simple;
	bh=2u2tbuWm344b7cQ1Bv8npkVNBQ2eJyK/GjFXIF1Ravo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cFbMtZQaGxNjPGTAyG8p/9qevUjTOX50a/kkX89DMlofs+n7ltwMi/mzPvFxhVpzjXJ0pyWIlM7X0IT/Zq0VJVKYlPOwo0BTN2RplxzSTPTJedRN93EylcTxf1tnWNn3LjyOaqERCiXmq08WqMCUDdsEh4FD/ynaHsTec2ZyVOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 29D99161D3B;
	Fri, 17 May 2024 00:37:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id D1E1D20026;
	Fri, 17 May 2024 00:37:40 +0000 (UTC)
Message-ID: <045de91c8b8e6c8ca60b2c4baf4430bd5cd5eeea.camel@perches.com>
Subject: Re: [PATCH 1/1] checkpatch: allow multi-statement declarative
 macros.
From: Joe Perches <joe@perches.com>
To: jim.cromie@gmail.com
Cc: linux-kernel@vger.kernel.org, akpm@linuxfoundation.org, Andy Whitcroft
 <apw@canonical.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn
 <lukas.bulwahn@gmail.com>
Date: Thu, 16 May 2024 17:37:39 -0700
In-Reply-To: <CAJfuBxxEgCT+4SVAxoWb1xvAqhgij489=z+FH9iuXwYksm-RWA@mail.gmail.com>
References: <20240516141418.25345-1-jim.cromie@gmail.com>
	 <4a77b3a77db293acba504914af220d8b8d644616.camel@perches.com>
	 <CAJfuBxxEgCT+4SVAxoWb1xvAqhgij489=z+FH9iuXwYksm-RWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: D1E1D20026
X-Stat-Signature: sy3eqq9ptsyt36cdswt3eeq5dr3heyok
X-Rspamd-Server: rspamout05
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19mJWOBsuitzZoFDDdKKFe0rs6zwYgxyR8=
X-HE-Tag: 1715906260-918204
X-HE-Meta: U2FsdGVkX1+b4uAbfptnZ0OjIR+CM5A6IiIKvrqtFBOgidIqO4OS2/S1DJCSkY1MuW6z0wabdYFENQWNTTHUknWm81onCFvnluL7HNij21An9jqtfTMT8pmyGGFXYZxyVgqa6UTiJu5NV/dZZFT9khbzJef3bkfUE/PR+wmIcICx0IWT/VVN9vzJQn/ltY8QnQbubh63e/wVTBnmXMl9b+mGHWquJtmtq/Ww/mXtbO+KoWxsqsU+4i9FYfUkbfxM8VYrqs3dejbFo9KCIRjideVJdwryNYyeNjLh9iUrSO23nJf20OCkFmDl0Q266xTujDWBHstC3BlcAgT0t6q5X9Bydjq8yDpEuVZGPZHqYgHTWuqHzd62QD92suNfKXY/CEnZXn4omBinoXy2lm+Wfg==

On Thu, 2024-05-16 at 09:20 -0600, jim.cromie@gmail.com wrote:
> On Thu, May 16, 2024 at 8:43=E2=80=AFAM Joe Perches <joe@perches.com> wro=
te:
> >=20
> > On Thu, 2024-05-16 at 08:14 -0600, Jim Cromie wrote:
> > > Declarative macros, which declare/define storage (at either file or
> > > function scope), cannot be wrapped in do-while statements.  So
> > > checkpatch advice is incorrect here.
> > >=20
> > > The code has an $exceptions regex which allows multiple statements
> > > based on the macro name, etc; /DECLARE_PER_CPU|DEFINE_PER_CPU/ are
> > > currently accepted, widen those to accept /DECLARE|DEFINE/.
> >=20
> > It seems this exempts too large a number of these macros
> >=20
> > $ git grep -P '^\s*\#\s*define\s+\w*(?:DECLARE|DEFINE)\w*'|wc -l
> > 5075
> >=20
>=20
> wow, thats more than Id have thought.
>=20
> > How about somehow limiting these exemptions more strictly?
>=20
> agreed.  I'll just add my 1 exceptional macro name.
> resending shortly.

Is this macro used in a lot of places?
Otherwise, why not just ignore the macro where it occurs?


