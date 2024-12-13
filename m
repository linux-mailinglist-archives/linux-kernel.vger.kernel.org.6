Return-Path: <linux-kernel+bounces-445084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0941F9F1104
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 261A2188394E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4DC1E2850;
	Fri, 13 Dec 2024 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RCfPk2I9"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7342E1E25EA;
	Fri, 13 Dec 2024 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734103736; cv=none; b=n2CkRgUzkPkaWZ8Id1JDmIzNJ4Lr76SSqcnLBJiYImsStHU/ZzhNyEX3RoIpOiy9TIGPBtFycnUfIASO+3XNoDPQ98wbYgludu8cIue3/OM4/6LDuQjJi0zjku7MZZ1+R5axPDtXNR7/IwwpHrcLkWhCS7f8g+7p+IJa5i6D26I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734103736; c=relaxed/simple;
	bh=hqRZ6dn+eREKBjKhUZdWiXvrYAwInb1fPmI75e/MYx0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=JcAIHcBjLGT9PdpK2FCxeRcwvGyipNDvaAzh7HVa6RaCl8E8ojR274PPOEkRFGJ07OBZ3Ak4KPLxy8ucBwswsvGJ3U/6KhVT3/us6mhUZc8xan7+UiseIVTV0Hq/FVPSIIaEP3USxc/yyfftWtsQv1J5TSH67duN5ByfNUsVyc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RCfPk2I9; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 143C94000D;
	Fri, 13 Dec 2024 15:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734103731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hqRZ6dn+eREKBjKhUZdWiXvrYAwInb1fPmI75e/MYx0=;
	b=RCfPk2I9+5mLLiIe9f/HJsOEZW2WsldFsV8snRVTTH/oObO1X+rZPmHIywEyoUv15XYtYI
	RBlsXK3Zz0s3Vp9RAiMvK5c6kqQXsOgCpA6LhgVtnfLOfycWfuVz8aQ9THRyz4FKjv5Jr5
	EAI1OwSi0am6SBXDkRZu6mSzZSsx4sBnbufRLMVAXF4Y8U3x5bqJlFB2GLjn1JrZGI2hRe
	0xxYLknhy7x/PrdtgboW0MxCBFrDtPQV4PvwYvm/RCEeYG5akuu51hneiO3eWzbf/LtlC6
	85NA7SEzjL4rE1kAIFvxj8fQO0IhYyyye0pO5VvcHFMMpTKMfLpWZAJN0ZqsLQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Dec 2024 16:28:50 +0100
Message-Id: <D6AOGW7IXUEK.1AKKZZT0LAF0Q@bootlin.com>
Subject: Re: [PATCH v6 2/5] usb: cdns3-ti: run HW init at resume() if HW was
 reset
Cc: =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, <linux-usb@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Roger Quadros" <rogerq@kernel.org>, "Peter Chen"
 <peter.chen@kernel.org>, "Pawel Laszczak" <pawell@cadence.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Mathias Nyman"
 <mathias.nyman@intel.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20241210-s2r-cdns-v6-0-28a17f9715a2@bootlin.com>
 <20241210-s2r-cdns-v6-2-28a17f9715a2@bootlin.com>
 <4e1eb8d2-c725-4572-8419-3027cac10c92@kernel.org>
In-Reply-To: <4e1eb8d2-c725-4572-8419-3027cac10c92@kernel.org>
X-GND-Sasl: theo.lebrun@bootlin.com

On Thu Dec 12, 2024 at 1:18 PM CET, Roger Quadros wrote:
> On 10/12/2024 19:13, Th=C3=A9o Lebrun wrote:
> > At runtime_resume(), read the W1 (Wrapper Register 1) register to detec=
t
> > if an hardware reset occurred. If it did, run the hardware init sequenc=
e.
> >=20
> > This callback will be called at system-wide resume. Previously, if a
> > reset occurred during suspend, we would crash. The wrapper config had
> > not been written, leading to invalid register accesses inside cdns3.
> >=20
>
> Did I understand right that the Controller reset can happen only at
> system suspend and never at runtime suspend?

J7200 + upstream kernel =3D> if the power domain is cut off (it is
implicitly at runtime PM) then it resets. This is 100% board dependent.
We just never let it go into runtime suspend, for the moment.

> If so do you really need the runtime suspend/resume hooks?
> you should have different system suspend/resume hooks than runtime suspen=
d/resume
> hooks and deal with the re-initialization in system resume hook.

The patch series works in the current setup with the wrapper that is
never shut off. But it would also work if someone decides to use RPM on
the wrapper.

Overall, the current kernel-wide strategy is to minimise
suspend/resume-specific code. Having only the concept of "runtime PM"
and triggering that at system-wide suspend/resume is easier to reason
about. It unifies concepts and reduces the states a device can be in.

We could even imagine a future where ->suspend|resume() callbacks
are pm_runtime_force_suspend|resume() by default.
That'd be the dream, at least.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


