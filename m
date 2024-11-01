Return-Path: <linux-kernel+bounces-392598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A94F59B9605
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38B29B224C2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 16:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCDC1CC178;
	Fri,  1 Nov 2024 16:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="dHtuGpsh"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7751B1C9DFA;
	Fri,  1 Nov 2024 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730480245; cv=none; b=hF6fAevXrL06ClxF13gizfbCu6j4121E1jp6Mo8iERwsBTCURZjXEy8RR7Bp56fCF5/nr5rYUYW5YZ5Fq+F7zV/IFy4e9z3NstdUdDbKhpOaoj/mvpcubYsrZqPqWNoJx+EqGypN26MFVQMmJA434kNAfXEfr9JX64iV9RKOMQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730480245; c=relaxed/simple;
	bh=2rKsatq5LG+9IKHuStVw7bDmC0tFVIV2dLq/aDxa/bM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hn7gs9fk4iD/1ZPs5vYoJs0YRoKA7Jn3/x0WLe4GzU36YjPsa4uAFpxKJ6XLYHRLSe523vR3OU9Hm1H4nHPsMDCv6Lj2tS5a+vURi3kXffw2JmLhrLCa1EoviwbwalZClnmPVXpgzcPE5lgiidny2MoAIK+aWRw8PYTV57bu1ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=dHtuGpsh; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=rz0ryjT9mPDcej02Hk6SsCveNSUKvfeMX0qnfVx6BcQ=; b=dHtuGpshL5PlID52fzj6TToJtB
	voL1NnNpNpigoGyWGbG1JIHgxlYkjHE07feIqQSWiFQ4TLqEjZANCHWP7+drN0m0hFsEj+uZDgYjG
	oEKIs4ZbmTlp6UGJkxopWOmAlJR7HcQHCVGUUi9/udSAE4H9vrcyFzgIRN6I1myLXajOjJ2erqw86
	2XOLj1Ua1l1Qrdm8sYu3Psp++nGNAY50w2oazW6cAkZvI7qLzhvWIGN+yhhZ7BVwzATWnRroG7Pqs
	k6MQJhLIEI3s0CWqFb+j+LLCAC4FAJU4Ih2eFUZVtKoMCWrg5nb47Kun60Q4qidMPojx16jEebAr+
	GtKgcKAA==;
Date: Fri, 1 Nov 2024 17:57:04 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Alexander Stein <alexander.stein@ew.tq-group.com>,
 linux-arm-kernel@lists.infradead.org, Shawn Guo <shawnguo@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, imx@lists.linux.dev, Conor Dooley
 <conor+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] ARM: dts: add Kobo Clara 2E
Message-ID: <20241101175604.20bc5427@akphone>
In-Reply-To: <172986441097.1907834.7871985467741599221.robh@kernel.org>
References: <20241024142206.411336-1-andreas@kemnade.info>
	<172986441097.1907834.7871985467741599221.robh@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; aarch64-alpine-linux-musl)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Oct 2024 08:55:18 -0500
"Rob Herring (Arm)" <robh@kernel.org> wrote:

> On Thu, 24 Oct 2024 16:22:03 +0200, Andreas Kemnade wrote:
> > Add a basic device tree for the Kobo Clara 2E Ebook reader.
> > It is equipped with an i.MX6SLL SoC. EPDC PMIC drivers
> > are not ready for mainline yet.
> > 
> > Changes in V2:
> > - improved commit message about devices without binding
> > 
> > Andreas Kemnade (3):
> >   dt-bindings: arm: fsl: add compatible strings for Kobo Clara 2E
> >   ARM: dts: imx: Add devicetree for Kobo Clara 2E
> >   ARM: imx_v6_v7_defconfig: Enable drivers for Kobo Clara 2E
> > 
> >  .../devicetree/bindings/arm/fsl.yaml          |   8 +
> >  arch/arm/boot/dts/nxp/imx/Makefile            |   2 +
> >  .../dts/nxp/imx/imx6sll-kobo-clara2e-a.dts    |  23 +
> >  .../dts/nxp/imx/imx6sll-kobo-clara2e-b.dts    |  23 +
> >  .../nxp/imx/imx6sll-kobo-clara2e-common.dtsi  | 514
> > ++++++++++++++++++ arch/arm/configs/imx_v6_v7_defconfig          |
> >  2 + 6 files changed, 572 insertions(+)
> >  create mode 100644
> > arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dts create mode
> > 100644 arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-b.dts create
> > mode 100644
> > arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-common.dtsi
> > 
> > --
> > 2.39.5
> > 
> > 
> >   
> 
> 
> My bot found new DTB warnings on the .dts files added or changed in
> this series.
> 
I think they all come from existing dtsi.

Regards,
Andreas

