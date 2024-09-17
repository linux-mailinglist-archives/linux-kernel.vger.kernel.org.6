Return-Path: <linux-kernel+bounces-331705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7261397B049
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 14:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28DBD1F24F8B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A9C174EFA;
	Tue, 17 Sep 2024 12:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="XvlPB5oJ"
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [178.154.239.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE7D173355;
	Tue, 17 Sep 2024 12:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726577043; cv=none; b=c99PKhD6lPveVSdYsJsApXC/0yIALbd8qh/xyOAcKUoK0pNPaXuIwgFqJPiVK5Xwm/Z1gcXsirIzvD+Wa/TCaiaIfq7vRF69AZc0l+hxZM1AFK8jZCXDuh85SGaXyx3vPhmKIIcMkacB80i9ludH+OZn2xUPyvMTrf3pFdhd18c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726577043; c=relaxed/simple;
	bh=jdfEh4dxPG5xskOJFTHgFWFO6196Eo2IN8fhtjLmngI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YaODG5ElBRAGv656waKkm6w1VxKe4y/HDN4K9+alFS0isIrh0lpM+zCyHa6NHcJ6a7ws3JWJo7fUxhWKJ9RO2Q2zs/9te2suCcpK1frPfboxZreV5BuK06YdV+0uRxgdx8n8uZKCnWWAhmkBmCq9T60XxX1I9KjlX1nsziaYBY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me; spf=pass smtp.mailfrom=maquefel.me; dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b=XvlPB5oJ; arc=none smtp.client-ip=178.154.239.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:1699:0:640:fad2:0])
	by forward502b.mail.yandex.net (Yandex) with ESMTPS id 222295F578;
	Tue, 17 Sep 2024 15:43:49 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id lhLgoF7XxGk0-ijibTgbJ;
	Tue, 17 Sep 2024 15:43:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1726577028; bh=jdfEh4dxPG5xskOJFTHgFWFO6196Eo2IN8fhtjLmngI=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=XvlPB5oJN08xt3z3LONt4eoNiUdXSVQIHRVhVryoGM2niMfc8Gq4NcW4z60ol1hJU
	 5cWn4qIHOpnhXo8amEt6Ra5PbxFzh2fvBuOdMHDK6iVrGbx5UmvMPeR6BQh5/rfgIi
	 h+VaYF6KMToGfBzn+Oe3DgaZo7IWn3MIJaN3RLKA=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <e9367879f2305fba1029aee546160537894e848c.camel@maquefel.me>
Subject: Re: [PATCH] MAINTAINERS: move BK3 machine support to CREDITS
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Arnd Bergmann <arnd@arndb.de>, Alexander Sverdlin
	 <alexander.sverdlin@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Lukas
 Bulwahn <lukas.bulwahn@redhat.com>, Lukas Bulwahn <lbulwahn@redhat.com>,
 Lukasz Majewski <lukma@denx.de>, Hartley Sweeten
 <hsweeten@visionengravers.com>
Date: Tue, 17 Sep 2024 15:43:47 +0300
In-Reply-To: <d125b5a5-8118-48ec-8af4-243a217170df@app.fastmail.com>
References: <20240913115021.58405-1-lukas.bulwahn@redhat.com>
	 <d125b5a5-8118-48ec-8af4-243a217170df@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Alexander, Arnd.

Do you mind if i put myself to EP93X, right below Alexander in
MAINTAINERS list ?

On Fri, 2024-09-13 at 12:24 +0000, Arnd Bergmann wrote:
> On Fri, Sep 13, 2024, at 11:50, Lukas Bulwahn wrote:
> > From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> >=20
> > Commit 3e0bae7f35c9 ("ARM: ep93xx: delete all boardfiles") removes
> > ts72xx.c, but misses to adjust the ARM/CIRRUS LOGIC BK3 MACHINE
> > SUPPORT
> > section, which is referring to this file. Hence,
> > ./scripts/get_maintainer.pl --self-test=3Dpatterns complains about a
> > broken
> > reference.
> >=20
> > As the corresponding file of this section is gone, remove the whole
> > section
> > and note this previous contribution in the CREDITS instead.
> >=20
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> > ---
> > Arnd, please pick this quick administration fix on top of the
> > commit
> > above. Thanks.
>=20
> The machine should still work as before, I think we should
> instead adapt the path to point to
>=20
> F: arch/arm/boot/dts/cirrus/ep93xx-bk3.dts
> F: arch/arm/boot/dts/cirrus/ep93xx-ts7250.dts
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Arnd


