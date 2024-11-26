Return-Path: <linux-kernel+bounces-421820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF139D908E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 03:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6BC528C548
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 02:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BD05473E;
	Tue, 26 Nov 2024 02:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailfence.com header.i=falaichte@mailfence.com header.b="qciQC2c+"
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com [212.3.242.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1393D96A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 02:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.3.242.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732589904; cv=none; b=Q8VQ87qYEo7wg2bUdvPYgrmD/dOhHtOS2CKi/zjG+/rbRgy3aEDJKiFvIkHsirHdhEuH+uE48TbgRoyzEQWdS2bMXTbUKAvrsC6koorFXCLkneoQIc5ZJfokekohOpFl/o4/LYK6FMwBMUSIYw76pasc7YZcI7ugqmgC8eJmtv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732589904; c=relaxed/simple;
	bh=6a12VeX7pVdq6KTVFgGxfasAQPNxM5LDnFArDCh+jU4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=eL+qd46iUrGXG6ti7jhcXXh+8C+J6opuaYD4+5tK2BnlJP6WOfK15gkPpKM4JJR2gEWjC6loK0ZFHBT+SAXa8NlFLyXrzagudqchHpu2Bh73lZAD2azYFDOmUB2U6sDORKgpbT83yaOoenlorGU8IIbjObHi/DGrT2L15L0f5JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailfence.com; spf=pass smtp.mailfrom=mailfence.com; dkim=pass (2048-bit key) header.d=mailfence.com header.i=falaichte@mailfence.com header.b=qciQC2c+; arc=none smtp.client-ip=212.3.242.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailfence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailfence.com
Received: from fidget.co-bxl (fidget.co-bxl [10.2.0.33])
	by wilbur.contactoffice.com (Postfix) with ESMTP id BD5326C6C;
	Tue, 26 Nov 2024 03:49:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732589359;
	s=20240605-akrp; d=mailfence.com; i=falaichte@mailfence.com;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6a12VeX7pVdq6KTVFgGxfasAQPNxM5LDnFArDCh+jU4=;
	b=qciQC2c+HeWgE7garLHk5NfBCVkBpJeCyaeL1dI3q9diahgOZJfnuF2QCksOGSg0
	L5k0mbtkwy0xW76LVykchEB+5leM7IiSlJG91KFdg93K6DV6XMo7MIUDGOUvT6sUGXo
	Dg9XQr7NomCjCkPxJTcP04sI500VChEozM3HpQ6crfHf43PVq5ah94mJsroYxFJVWHk
	0JzMkjhdZI3OVkRwglZKolgq4VGt5Tvnb/u9FXdbySXFGGF6lOOA0DOR3WK/xITTV/c
	9WVbC6Y4kPmRjZxjVEuQYXCdscPymfWbZI34OcVyQdeRItbmJ2AUufqQDjja4xzdjO8
	91gn6/cFyQ==
Date: Tue, 26 Nov 2024 03:49:16 +0100 (CET)
From: =?utf-8?Q?Dylan_=E2=80=8E_=E2=80=8E?= <falaichte@mailfence.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org
Message-ID: <178683687.1369157.1732589356785@fidget.co-bxl>
In-Reply-To: <1644432842.140359.1730824451296@fidget.co-bxl>
References: <1116521637.127547.1730818127738@fidget.co-bxl> <1552791356.130304.1730819601359@fidget.co-bxl> <237077017.130501.1730819723674@fidget.co-bxl> <20241105160622.GV1350452@ZenIV> <1644432842.140359.1730824451296@fidget.co-bxl>
Subject: Re: Russians in the Kernel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: ContactOffice Mail
X-ContactOffice-Account: com:490142097

Thought I'd check back in as the thread bares repeating after the recent in=
cident with Kent Overstreet. The Code of Conduct is not being fairly applie=
d across the entirety of the Linux kernel development space and I feel that=
 the direct violation of the Code of Conduct by the Linux Foundation and Gr=
eg Kroah-Hartman by discriminating against a group of people for their nati=
onality and ethnicity should be addressed at the earliest convenience.

On Nov 5, 2024 at 4:34 PM, "Dylan =E2=80=8E =E2=80=8E" <falaichte@mailfence=
.com> wrote:> For another,
any proxy set up to bypass the sanctions that really exist (i.e.
based on employment by sanctioned companies) would fall under the
same sanctions.

You could make the argument that sanctions as per the laws of the United St=
ates
is itself unconstitutional as it impedes people's right to freedom of assem=
bly.
Even then, there is still the point that the Linux kernel and similar open
source projects are transnational communities and by prohibiting access to
participation you aren't respecting the spirit of free and open source
software. Where anyone may participate regardless of their walk of life. I =
can
understand not wanting to incur the wrath of the American government and th=
at
it is better to comply in some cases than make a stand as has been the case
with Nintendo and emulation. I just simply don't like the amount of
governmental overreach with that particular executive order and believe tha=
t it
should be undermined wherever legally possible.=20

Though I'll understand if the idea does end up getting anywhere. I just tho=
ught
that it was worth sharing nonetheless.

> For another, you really don't want to set anything with even
the slightest whiff of "that's how to hide patch origin and/or
evade review" - that's an open invitation to any organization
that wants to feed something underhanded into the kernel.
Won't be a healthy place to hang around, to put it very mildly.

The difference is that it would all be above board with the intermediary ac=
ting
as a buffer between those targeted by sanctions and the work they've done. =
It's
all open source anyway, so there's nothing that can be done if their source
code was forked and then used upstream in a patch series.

--=20
Sent with https://mailfence.com =20
Secure and private email

--=20
Sent with https://mailfence.com =20
Secure and private email

