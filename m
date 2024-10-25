Return-Path: <linux-kernel+bounces-382687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B711E9B121E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 23:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8D191C2109A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 21:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B94920C333;
	Fri, 25 Oct 2024 21:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="ktOPSKsc"
Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8F01DACB6
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 21:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729893571; cv=none; b=Tff1IUwA6GOpw6Bmvktvv6OxgDigUKxiO+sZn8j+1m/7+1Y3AhzZvnbS1Wmtb3CrekZeaCiUwRuvTIvBOMx5ZzUCXmWAr+mR3skx7pg1GWPha8y9fJAGwrMNZNMtOG7aEO8klvqi7dtpaJQJ/4zA8qI4CkjzCN30mjgk8Twl0Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729893571; c=relaxed/simple;
	bh=ExIaH/LJ/aNg/2yaD8FcSyLJM/6DYDD97zd8MPsw3mw=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=ABJ9h2MeGNH7jI1YWNf2QMtwqFujuoyjdWwADRY3fxuIRXD8B+uADazXqz119miiNURl3SMVZlkccOLSUUeZ1m1AKwhNRN0XLJPcaqkFs9uydVKFb5yAh9QUEZlqDmiM4r5X6p641yrCj0q1XDDx4gfc+9EnNNkMDytQg3xOSF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=ktOPSKsc; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1729893567; x=1730152767;
	bh=ADFFmKxl22EBMizPHfrzw7Sz5HVTJc5GX20Kc/P8Aec=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ktOPSKscO1k35WHSIPHHCenUaQXvx0iHCGQ4VbRVBYqP/S6w9TeMYvfSu22dLVjGZ
	 1SRqVKsR/R5LXuFpWVkl5zuHbvb/hUiiuWEkpFgSheZS+gy754om6Inr8L2Jlf/PdE
	 J/tW7Vz4V4mwZpd24CYfR97JlS3ZPtAC6lRgOkL3CiSlaFd0uXzEdY7FtNmcrdbQNs
	 68/wfbz9hmYgy5NtDb3fUZYR+xy2JUkKPI4QHPY46Ou+qiozlZBCnV4uvWfCaNHFgB
	 uu4PNq+p7cXSvJXMSTp2PFonSyNRglDmlFykm3bXy7j2AVo8aRzYX28RT08gNgwxSR
	 WNDjbZ8cai//A==
Date: Fri, 25 Oct 2024 21:59:23 +0000
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Joe Putin <joeputinx86@protonmail.com>
Subject: Righteous way
Message-ID: <Cu259VlZbjbFcgBXebzmu43nGfbvfdL3A2Tz64s3_dR19HfF1axcFCf0dsVPkNvLL-I6qf6xhShQ740MXihL8zNulxh6FxXUTk2sIhAgEoA=@protonmail.com>
Feedback-ID: 123953413:user:proton
X-Pm-Message-ID: 68c3d9064746c97bde74c1e77c71a84f52c95068
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

There is certainly a positive development, since for the first time, we
realize that the code we write could be used in mis*iles/weap*ns that
b*mb people like you and me. Our families, and our children.

But it's important to discern "the people" and "the army". Since, people
all around the world are just like you and me who are trying to survive
this world.

The best way out here is that we ask these rouge milit*ries to publicly
release the code they use to mass*cre civilians. So, we can put them to
shame for the algorithms they use to decide who gets to live and who
not.

Linux is GPL license which requires derived works to be publicly
released. Hence, not complying would put them in a morally and legally
wrong position.

For the milit*ries that are conducting brutal Gen*cides, b*mbing
hospitals, schools, refugee camps, homes. We must speak for the
innocent civilians.

But we should not side with those, whose objective is ambitious pursuit of
wealth and power, At cost of the commons.

Linux kernel is the epitome of what collective human effort can achieve.
The internet has enabled us to communicate, otherwise we would all be
brainwashed by our respective government's pr*paganda. Let's make use of=20
this for good.

This world is already a terrible place, let's not make it worse.  We
"the people" stand together.

