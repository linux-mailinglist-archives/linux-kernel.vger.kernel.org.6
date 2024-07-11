Return-Path: <linux-kernel+bounces-248848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5616692E2A6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0E7D1F22654
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44B8153581;
	Thu, 11 Jul 2024 08:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="jQqR5yg6"
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B554315B;
	Thu, 11 Jul 2024 08:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720687513; cv=none; b=F6kBioAA4u+r4fxHm8b+32KTrMTnrsx1EPNCm+nafTBLn7A+dnjyVJ+/8i0n4g0F+zms878HobRDy/sTHSCSNxbBAXXwgMzvv0hqh2G3vSMzWV6S7OcYTsFyzdH8En7ypz2Ey2pRjJMmOBmrWd/Lx4hoxz3wSz0SgQPlO31zRYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720687513; c=relaxed/simple;
	bh=QRGxbfH+3SeKRG16yQOvBXWdakQh0M8wwO69vXLtBIc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:To:From:Cc:
	 References:In-Reply-To; b=kNcyEVdKSpBG+9pqn8039PVyyZ/1VYpq6gRMjCnqAcskOTRdA7+B+sfWjoFtSubkNqZ3jPkkG0kyex8inwqRsGUUPDzmEp75hxsWNHvBv6wI2ae6lz7Chg3t56BD7SkLudwuOEoteakwaWr1XWaTe+VkcTDcGEo4U9fAO/Fxpf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=jQqR5yg6; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1720685852; x=1721985852;
	bh=Ls7RNbnmxHwm0IM0YhzLBLizkdiPlt+11EedtmZU+3k=; h=From;
	b=jQqR5yg65sj8UpliFuByNMMGwzvR1CSXBc80hFLXtB02fQckgr/codwkbToD8dccv
	 lMgXuGngFliqna6YO5PN1W6VQqxVVXFCh+uSKzQ7Wc5T+szbBqZUHiT8UvJPkj895y
	 ylG05nbvZu4C45fY++oEI7b0NiRzOrar5QgSMXBjYqYWJZ37VBD/hF2eg1CFIArK64
	 i5bRFwxYYQDWzNpe6+44UkL+X5Dc9p/Zk4k8nQhbGiunZB56Y+FYHPvsjgqypm3gkO
	 5lH6oLZqJ4nJfaFjEYRtpJ8ymHZHlcgb/mImq8OfVBGExgimVeiLpxREyJmzWh4sF4
	 QjkHQ4pq7NNIA==
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 46B8HVSV030720
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 10:17:32 +0200 (CEST)
	(envelope-from balejk@matfyz.cz)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Jul 2024 10:17:31 +0200
Message-Id: <D2MK87FSAP8Y.N9JBG2R7IBQX@matfyz.cz>
Subject: Re: [PATCH] MAINTAINERS: repair file entry in MARVELL 88PM886 PMIC
 DRIVER
To: "Lukas Bulwahn" <lbulwahn@redhat.com>, "Lee Jones" <lee@kernel.org>
From: "Karel Balej" <balejk@matfyz.cz>
Cc: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Lukas Bulwahn" <lukas.bulwahn@redhat.com>
References: <20240711065140.140703-1-lukas.bulwahn@redhat.com>
In-Reply-To: <20240711065140.140703-1-lukas.bulwahn@redhat.com>

Lukas Bulwahn, 2024-07-11T08:51:40+02:00:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
>
> Commit f53d3efa366b ("MAINTAINERS: Add myself for Marvell 88PM886 PMIC")
> adds a file entry referring to drivers/regulators/88pm886-regulator.c,
> but the directory is actually called drivers/regulator. Note that there i=
s
> no 's' at the end.
>
> Hence, ./scripts/get_maintainer.pl --self-test=3Dpatterns complains about=
 a
> broken reference.
>
> Repair the file entry in the MARVELL 88PM886 PMIC DRIVER section.
>
> Fixes: f53d3efa366b ("MAINTAINERS: Add myself for Marvell 88PM886 PMIC")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3eab44bd1010..bb7b5ecbc0b9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13495,7 +13495,7 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/mfd/marvell,88pm886-a1.yaml
>  F:	drivers/input/misc/88pm886-onkey.c
>  F:	drivers/mfd/88pm886.c
> -F:	drivers/regulators/88pm886-regulator.c
> +F:	drivers/regulator/88pm886-regulator.c
>  F:	include/linux/mfd/88pm886.h
> =20
>  MARVELL ARMADA 3700 PHY DRIVERS
> --=20
> 2.45.2

Thank you for the fix and sorry for the trouble.

Reviewed-by: Karel Balej <balejk@matfyz.cz>

K. B.

