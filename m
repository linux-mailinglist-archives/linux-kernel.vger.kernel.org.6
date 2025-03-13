Return-Path: <linux-kernel+bounces-559560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C282AA5F580
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5183416F399
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D93267AE5;
	Thu, 13 Mar 2025 13:09:24 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702A026772F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 13:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741871363; cv=none; b=rfGzJ+eZ+t6ZSzYakysKIP1P1jfiO4gwkg1oG8NznLRe8F+QsqdcfztDcAuv2gs55rPUNCEFSYlB94Y5JMV97iBbxTMiPw7N9A/vx+OOEfftRd1vlVQVkMxX3hP59sQkkXfsoPRcy7fEuXqb9gOeestWj2yxSxn7XoyxR1e96fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741871363; c=relaxed/simple;
	bh=ve2ATQHHnc36X4Fy/bS0Obe/zU7UQSKs/y99y/c4DFU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UxFv16Kc0UueBfAa9w+WS3CNFgs03v3D614u2KWRBbFmnIe9QFySLbEQKh9lsHkmSrgKk31D/9xw9bnhNllWWKC/stqg5vKV8N7vaNTeBopRhN+ec2UcdLX7jJVM9NgOjSVpr+2X2gjocMKe6q/p0KNQCtiP+hWt208LZDG1e68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tsiJF-0001jm-Ok; Thu, 13 Mar 2025 14:09:13 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tsiJF-005XU3-0n;
	Thu, 13 Mar 2025 14:09:13 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tsiJF-0009ur-0W;
	Thu, 13 Mar 2025 14:09:13 +0100
Message-ID: <18780ad4be2c28999af314c97ae4104fb161a691.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/2] dt-bindings: reset: Document RZ/V2H(P) USB2PHY
 Control
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Conor Dooley <conor@kernel.org>, "Lad, Prabhakar"
	 <prabhakar.csengg@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,  Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>
Date: Thu, 13 Mar 2025 14:09:12 +0100
In-Reply-To: <20250306-slather-audition-a6b28ba1483e@spud>
References: 
	<20250305123915.341589-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
	 <20250305123915.341589-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
	 <20250305-cesspool-headlock-4d28a2a1333e@spud>
	 <CA+V-a8uQTL+SHYqVU_J0th4PT6YPF7q6ypzDu33nS_6onWLoOQ@mail.gmail.com>
	 <20250306-slather-audition-a6b28ba1483e@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Do, 2025-03-06 at 16:26 +0000, Conor Dooley wrote:
[...]
> That sounds awfully like "it was wrong before, and I want to keep using
> the wrong node name"... If you're claiming to be some other class of
> device, "ctrl" should really be "controller" like all the other sorts of
> controllers ;)

There are "usb-phy-controller" nodes on the rcar-gen2 SoCs.

regards
Philipp

