Return-Path: <linux-kernel+bounces-181284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3081C8C79F6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 18:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FFA21C20CB7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A07314D6E9;
	Thu, 16 May 2024 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="SmNyTHWt"
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C260414D2AE
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715875238; cv=none; b=ea2gvQ2IyCO2n+CIZBn4DuPZBkgCnL0ST3GNV06P2nnMUsSFuqiENFgtH7BDLUCjoAeFPXhi39HXgaV9P+4+2XwKkRWuzpJkML3iON6TPk5NYHcESW+Y3fpTYQCfnbI1rdykGrW2h8lY8J1hlPRmpE9IF+HwR7bxbnyezfz375Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715875238; c=relaxed/simple;
	bh=RROxxPhxMtq0HkZs0u1KmYdIX+QELF6ptNfysJifQ5c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OSg2sZ14hAXExW51DFvK6S7DlLZyTYTV9Ph4V7vXs/Ozza80216hYz+WRfPPYwgCFjrWiKnrxq10l3Ga3L7uAYgC8yDzNUXbQzC+dV/V8xhDUq7/m30s/mA48fi9ICekMsTwbWIR1BIcvtt5t8UH0Bl24bjsKnYz+XD5E9DKiUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=SmNyTHWt; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1715875220; x=1716134420;
	bh=RROxxPhxMtq0HkZs0u1KmYdIX+QELF6ptNfysJifQ5c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=SmNyTHWtmXNuNeD1Oq7quI6S2hkya+ueMIca33ldecu9oLqDKDBZ0KI/wYPPa/Kyq
	 cV1X10jOy0WARsiH6ioh1fEjw3er8a67TRl121WUeBjpxIgLVeAJTmuV9AAtdNaPx+
	 SsSeTeY+LAdP1MQwitVQZbiF76h5ZHcF5/zGFNybJGVlLVALoFUXjk2st3G51W0zCr
	 6kaX74nGHnHwTEON9Dodt8XrB59vAqQk8Mn7ov1+mQHBlN5L0YlFCqq+s9BOzUVXKJ
	 6nHu9oquXK1DpA3ojqhqAn8IalHWyQqqtPERSlGdOpeV+Ts+IrafA7HSIiL9v6qVZA
	 SrH4s6UOyy+5Q==
Date: Thu, 16 May 2024 16:00:10 +0000
To: Conor Dooley <conor@kernel.org>
From: Kanak Shilledar <kanakshilledar111@protonmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Conor Dooley <conor.dooley@microchip.com>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, workflows@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] Documentation: process: Revert "Document suitability of Proton Mail for kernel development"
Message-ID: <4oW9pC38sSYZn96BW8abMfVpDDCmG4MDHwwmL73o5bP-WyHAutJ5j2GrSU17MCSWOKufViNl4q2zZUmwmN40evP5OK3QiMnUn2hsgWCYhl4=@protonmail.com>
In-Reply-To: <20240516-groin-slingshot-c3c3734d2f10@spud>
References: <20240516-groin-slingshot-c3c3734d2f10@spud>
Feedback-ID: 26271244:user:proton
X-Pm-Message-ID: 67644286d89954f6086eaacbeca6a1bf6868a4ff
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, May 16th, 2024 at 9:05 PM, Conor Dooley <conor@kernel.org> wro=
te:

> From: Conor Dooley conor.dooley@microchip.com
>=20
>=20
> Revert commit 1d2ed9234c85 ("Documentation: process: Document
> suitability of Proton Mail for kernel development") as Proton disabled
> WKD for kernel.org addresses as a result of some interaction with
> Konstantin on social.kernel.org
>=20
> Signed-off-by: Conor Dooley conor.dooley@microchip.com
>=20
> ---
>=20
> I tried to find the stuff on social.korg to provide a link
> but could not.
>=20
> CC: kanakshilledar111@protonmail.com
> CC: Konstantin Ryabitsev konstantin@linuxfoundation.org
>=20
> CC: Mark Brown broonie@kernel.org
>=20
> CC: Jonathan Corbet corbet@lwn.net
>=20
> CC: workflows@vger.kernel.org
> CC: linux-doc@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
> Documentation/process/email-clients.rst | 20 --------------------
> 1 file changed, 20 deletions(-)
>=20
> diff --git a/Documentation/process/email-clients.rst b/Documentation/proc=
ess/email-clients.rst
> index 471e1f93fa09..fc2c46f3f82d 100644
> --- a/Documentation/process/email-clients.rst
> +++ b/Documentation/process/email-clients.rst
> @@ -350,23 +350,3 @@ although tab2space problem can be solved with extern=
al editor.
>=20
> Another problem is that Gmail will base64-encode any message that has a
> non-ASCII character. That includes things like European names.
> -
> -Proton Mail
> -***********
> -
> -Proton Mail has a "feature" where it looks up keys using Web Key Directo=
ry
> -(WKD) and encrypts mail to any recipients for which it finds a key.
> -Kernel.org publishes the WKD for all developers who have kernel.org acco=
unts.
> -As a result, emails sent using Proton Mail to kernel.org addresses will =
be
> -encrypted.
> -Unfortunately, Proton Mail does not provide a mechanism to disable the
> -automatic encryption, viewing it as a privacy feature.
> -The automatic encryption feature is also enabled for mail sent via the P=
roton
> -Mail Bridge, so this affects all outgoing messages, including patches se=
nt with
> -`git send-email`.
> -Encrypted mail adds unnecessary friction, as other developers may not ha=
ve mail
> -clients, or tooling, configured for use with encrypted mail and some mai=
l
> -clients may encrypt responses to encrypted mail for all recipients, incl=
uding
> -the mailing lists.
> -Unless a way to disable this "feature" is introduced, Proton Mail is uns=
uited
> -to kernel development.

Instead of completely removing the Proton Mail section, can we keep the men=
tion about the Proton Mail bridge and the third-party hydroxide (https://gi=
thub.com/emersion/hydroxide) bridge.

> --
> 2.43.0

Thanks and Regards,
Kanak Shilledar

