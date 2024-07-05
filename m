Return-Path: <linux-kernel+bounces-242516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A6592894B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 15:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824F91C20F11
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21E214AD2D;
	Fri,  5 Jul 2024 13:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="RYIHpHiA"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF844143C79;
	Fri,  5 Jul 2024 13:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720184780; cv=none; b=Rzi4xgiuqjBb22rDgHhx7pCadmsTPF49ZFncbFD3UZr+p/H9jODX/lLg6wOHZTnYORB/aPXjg/r/9nf10dN6H45Dm7KrOpsWycRpABVs27l/VdFlms+rwSoPNejF3ZJuI1ZrPvtPuSEvtfy9ahFEIkosxRUhIvKpJWRLbWF9KSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720184780; c=relaxed/simple;
	bh=WmEhNgDAEyTZUHGmtQezCo9iVLbCkSzU0LJjSId6A9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mu1wGf6XddsW0fbUqpZOhk7Ei6dAhaRQVCLzKJ3iIUIQ097kMEKxhNdOIrQmQrFZsNtuGN3cJS1/9Bff0WGyGXK/sm0K+bP/7Dn+HKD0pFqkpuKvucl/+G4yPNfiyNETix+aA/HeSGd0RLCL4uAn9FnPfO+WPtEZRcHKscN/I3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=RYIHpHiA; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 7336E1F9C8;
	Fri,  5 Jul 2024 14:57:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1720184251;
	bh=WmEhNgDAEyTZUHGmtQezCo9iVLbCkSzU0LJjSId6A9s=; h=From:To:Subject;
	b=RYIHpHiA0QZ3wLmsP1vKyCuRUc0DKvv0COFTjmBHm5fEDEzKdHIo0SaP1OpdqR1t0
	 j60Xw390URTSJKHFVKtq+BuPOGSqeEanvkYkq0S2zrscWacY1AAboZXhKP76DQwnJs
	 9OW2pDuBbg+mo8La7WBFzpCXb+pUghVvvMkZFFeg/t/ktEcriC8Dg9r5pw39Xm6fJw
	 cvKkLrL/MPY77iVjnESuq+rDCLI2OscATmE7XIEPpMaUJB0N49+KswB3R1Om9sywrw
	 SJvSNDGUY1kEpzvSkqJCajvgb68V57wwKMRBytzidogpZtLlAJ+j4oJeKOKa4rREdh
	 4tPdlXxijpk2Q==
Date: Fri, 5 Jul 2024 14:57:26 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
	airlied@gmail.com, daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, tglx@linutronix.de
Subject: Re: [PATCH 00/10] Add Freescale i.MX8qxp Display Controller support
Message-ID: <20240705125708.GA73712@francesco-nb>
References: <20240705090932.1880496-1-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705090932.1880496-1-victor.liu@nxp.com>

Hello Liu,

On Fri, Jul 05, 2024 at 05:09:22PM +0800, Liu Ying wrote:
> This patch series aims to add Freescale i.MX8qxp Display Controller support.

I really appreciate your work here, I am looking forward for a better
support in mainline Linux for both i.MX8QXP and i.MX8QP.

With that said, would be possible to add to this patch series also the
required changes on the DTSI/DTS file to facilitate testing this?
Worst case you can just add those as RFC / DO NOT MERGE at the end of
this series when you'll send a v2.

Francesco


