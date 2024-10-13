Return-Path: <linux-kernel+bounces-362928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A502C99BB51
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 21:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13B97B2101B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 19:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B0B1474D9;
	Sun, 13 Oct 2024 19:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Wm9ciXPr"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB97D231CA0
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 19:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728848740; cv=none; b=MEGMuYScTPeAEkStjMxaJr44rKIvCP/j87rLMJOjst/XIom9/RV6b7opxOp1aIjJh1wKz+i13DycdLLDNMD+q/gqKrpGqnOW0gwJ7F3ckspgYf1q7kD9UVo8e04c+9q1hNvbkr6zHkmWRGn1ovSUfFnTpOlsllPPJkRlWkVnBfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728848740; c=relaxed/simple;
	bh=5PL/DzJk9M6Ksey3MnCAtp3ggcM75u+uEq5pEsQUfFw=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=WLFlcbyfWpXRxtv6ZBXOgrD2UVeA9JgrD6JJgTZs0GhEWMPTvUKax3q+idAZEOEeI9GVA1uggg4FG4bUTv7dmbmm2dOm9oiuwe1pKrpE75nz3oPuh8mj6wqQ3pU/PrGfxUCNVQ4XBBqjCc2a0LIYd89BWMVeefjicXm87ne/ncw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Wm9ciXPr; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1728848736; x=1729107936;
	bh=5PL/DzJk9M6Ksey3MnCAtp3ggcM75u+uEq5pEsQUfFw=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Wm9ciXPrNw8h/Tn8oye5qOIUbqRYI+2hlFQGPhSuon4US1nQih2VZxdPIVWF7Gybz
	 WiOjV02vxmJx/L2busE2bLa32WzZQVnESh8hfFIr83bdQ9v88TzHu4JVzIwkOZSp4H
	 PcuMgp8Qo+Rqy2HKzwU2aoTBWaEWY5E73Fw1ThMH7uiW2Ll2XfQz3OFeunML5iy9Ht
	 IOW6ctmud7vD6G/8XdfmtOXBx0SfJ1Y/xctJwbLVC3HDrVKnWRrkGjevHJ4l4Lv0vs
	 yTVVAmAYT5LH+HaLBa70pRlvuSe1EF1q4waZcCAdsQReI0HJ0DwpjmpZAEd6+ExxGa
	 ZLki87i70Er2w==
Date: Sun, 13 Oct 2024 19:45:33 +0000
To: "dpenkler@gmail.com" <dpenkler@gmail.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dominik.karol.piatkowski@protonmail.com" <dominik.karol.piatkowski@protonmail.com>
Subject: [RFC] staging: gpib: Proposal to add TODO file
Message-ID: <9kl5ApXnxfAqT4f8YvoMMU8hLdNC_Dd3ZfZj5UEGrLfWKU_PnImmkF7ZIFgiSq_Qt06oFVAQ04JfzSwfXree6_ZZ39c9d58Gd3rxCCZ2jUw=@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 3a7087128e7e758a5083bb3b844d4455e63c9f65
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dear Sirs,

The gpib driver was recently added to staging-next branch, with patches bei=
ng
few weeks old. It is currently almost 30k lines of code.

I suggest adding a TODO file, as majority of drivers in staging subsystem h=
ave
one. There are some things checkpatch complains about, and maybe there alre=
ady
exists a list of known other things to do. If such list (or lists) exist, i=
n
any form, I can prepare a patch introducing a TODO file for gpib.

Thanks for any response.

Thanks,

Dominik Karol

