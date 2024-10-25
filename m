Return-Path: <linux-kernel+bounces-381005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AB39AF8F9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 06:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2784A1F22EB2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 04:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A11218C351;
	Fri, 25 Oct 2024 04:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="KZAJuGyl"
Received: from mail-40130.protonmail.ch (mail-40130.protonmail.ch [185.70.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E0238DC7
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 04:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729831971; cv=none; b=WgX2RGShAy3Vt3gcY1DjzFFi8cGkoNcGdspClvfMJmbYm2O0Vzntw1cdjba09pSuj613YKXXxi6PGtogFLpLciG41uLScg5PqUVV19hp0MjjfDGgPX/JQ6BZ0rRWbLmbgH629XeoXIxuMQvoiSaz2bpe1zdlQpq4v47mguh1TIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729831971; c=relaxed/simple;
	bh=RGGpCfZfpksqP5CpiBryi//KERGu65h7PTpZDydu34Y=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=a3DvXYR7Py+g22S+WvDPLyAROXS2/WWqRDZKEVZCexmSmLMAt2pVkq+aON+aHfbBFLTvpsBDA40azQcb7I/olHPibmC23WbN5Egx6RDMZn1/MOmCdpIotNJWjiViiWqSCxjV1NDuS6QaMozglNsKcQ1ct1+SzLKS8eWdiieSnoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=KZAJuGyl; arc=none smtp.client-ip=185.70.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1729831966; x=1730091166;
	bh=RGGpCfZfpksqP5CpiBryi//KERGu65h7PTpZDydu34Y=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=KZAJuGylY36SM06guinxRI52yJB3ndWuxWumXC71pZGHtKtV7n3fjtvCy90ueAfLx
	 vnYuJ8uAtI5NcdNtQddgkDKjtwt56DRr0aU/KQrRxEhRT6lvP1yGkGKFdK9yXqOjIs
	 goUfMTjswtEIXa8Os9eWSeVhmJqvyikZnT8wDWuWOaQ9IyN20JgGNNayd3TWyWZpO6
	 XDJid5E/PGk2IVouBmFJOeXrQlZ/af/km8AO6ettEIk9kYGn08G5o8GvLamQZ7tDSK
	 yb6Kd/mj6fuYReWZF5NbjCqF2cnnMzJ1DTgMEZ7l3sobJAt22YOKngMYXtlXRTHrtA
	 mDaWhYf9BpahA==
Date: Fri, 25 Oct 2024 04:52:41 +0000
To: masahiroy@kernel.org
From: Edmund Raile <edmund.raile@proton.me>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, regressions@lists.linux.dev, stable@vger.kernel.org
Subject: menuconfig: missing options in drivers - input device
Message-ID: <5fd0dfc7ff171aa74352e638c276069a5f2e888d.camel@proton.me>
Feedback-ID: 45198251:user:proton
X-Pm-Message-ID: b7d4de6d7f34852a123a3b469c793833afcf5c2a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,
I'd like to report a regression to menuconfig.

In "Device Drivers" ---> "Input device support"
There used to be submenus for keyboards, mice etc.
Now, only the entry "Hardware I/O ports" remains.
They can still be accessed (and configured) by searching for them,
then pressing the corresponding number:
/Keyboard
/KEYBOARD_ATKBD

I also determined the commit:
f79dc03fe68c79d388908182e68d702f7f1786bc
kconfig: refactor choice value calculation

#regzbot introduced: f79dc03fe68c

I've only encountered this here but it is not impossible other entries
elsewhere in menuconfig might be missing aswell.

The issue is present in stable 6.11.5 and mainline.

Kind regards,
Edmund Raile.



