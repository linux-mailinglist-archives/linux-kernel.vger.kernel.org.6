Return-Path: <linux-kernel+bounces-382849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A769B13F8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 03:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791BD1F2335D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 01:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0922AEF5;
	Sat, 26 Oct 2024 01:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="qicdpxs3"
Received: from mail-40132.protonmail.ch (mail-40132.protonmail.ch [185.70.40.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57D8101C8
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 01:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729905160; cv=none; b=sBuadYoWmbEltsIisXZBQ9yH7Hq+4w1zzDDBQ9Jhkdo4O9SfF1uk6gWylf2Cdz/GVlJAps8neYkn2S2puMYEA/GVU9LnCd1WeGkP/cUTgKfqjvCHlTkJYOPOSrFVw1Nsgbf/KWDvya7CMSDj2ZttmDmTYoODVl4rD6F5p7YE1Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729905160; c=relaxed/simple;
	bh=l0J++z5bUxW/lfru5HcGgHaNpRXgshd5/6b0H4mjGT4=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=jE7E4ionrluZB4cBHZ+GEEvHnij7LUodbB2i+036uqFIrYb38iRw5auWcsKCAvXBhOlMZI5gDlyXrm3KEDPCLzkK+iE747abp/PwUhd8LcqMbjj0RXmDtLurRFUYNeZs1/vRETFnHOSFQ/5h9Ktebf7DJLN0PwIdibo6ihwCZLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=qicdpxs3; arc=none smtp.client-ip=185.70.40.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1729905156; x=1730164356;
	bh=l0J++z5bUxW/lfru5HcGgHaNpRXgshd5/6b0H4mjGT4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=qicdpxs3a3jLRG1JQ2kIKEtucj/lq+w0iTFbj+MPQuTLOTvUgSgvP61nGKi12pKaM
	 CTfscSTMtUnlU2gBjoDv1IhuIIEugS8gqWHEVlokhf7NSWzEGv8z+8Bjk4uQNlA4JT
	 Iwm05ltiXqzbv/WrhUWClhH16l3hC6y0+UvnA/BwQCpQTf9R/D7vtkiSPd9wYQjn85
	 Sfvhj1Bxfthh2/FLx1aGjqaOPHRpZ9a4s1zlTt4A/OORxrwR/fCRclUb/p+ULRvXac
	 EA8J2URSV0Yhx5Tlwfah8CqMf0u/gxU4ta89HHkERDl4Z8dxhH38UMROupCyLLhOGv
	 4QBlqrWg0QD8A==
Date: Fri, 25 Oct 2024 21:12:27 +0000
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
From: Joe Putin <joeputinx86@protonmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Remove some entries due to various compliance requirements
Message-ID: <sVXB8QIhDTUMzW_7mfch_sRnN9KHnRjYjCac4zBmCay7qJkJyPEztYv1Na05J1Hrt8ibulFnMgVz5GLDUIWV5o3qY_FmX-EjeYRlMK3uols=@protonmail.com>
Feedback-ID: 123953413:user:proton
X-Pm-Message-ID: dc9ebaba03bb2563a86090e6fc9a1541fa8424d0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This is certainly a positive development, since for the first time, we=20
realize that the code we write could be used in missiles/weapons that
bomb people like you and me. Our families, and our children.

But it's important to discern "the people" and "the army". Since, people
all around the world are just like you and me who are trying to survive
this world.

The best way out here is that we ask these rouge militaries to publicly
release the code they use to massacre civilians. So, we can put them to
shame for the algorithms they use to decide who gets to live and who
not.

Linux is GPL license which requires derived works to be publicly
released. Hence, not complying would put them in a morally and legally
wrong position.

For the militaries that are conducting brutal Genocides, bombing
hospitals, schools, refugee camps, homes. We must speak for the
innocent civilians.

But we should not side with those, whose objective is ambitious pursuit of
wealth and power, At cost of the commons.

Linux kernel is the epitome of what collective human effort can achieve.
The internet has enabled us to communicate, otherwise we would all be
brainwashed by our respective government's propaganda. Let's make use of=
=C2=A0
this for good.

This world is already a terrible place, let's not make it worse. =C2=A0We
"the people" stand together.

