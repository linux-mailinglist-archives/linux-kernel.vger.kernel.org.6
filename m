Return-Path: <linux-kernel+bounces-356494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BB79961EB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8FE81F23073
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9718E184527;
	Wed,  9 Oct 2024 08:10:15 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05DA184528;
	Wed,  9 Oct 2024 08:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728461415; cv=none; b=cAFqSKQpHOTHOKTSgkYO3Ci1TAMAZMh6t6PAnL2bQ+6W7I+kWZeeo5skaIzzboN5ZBXdrEvooYyJ63CT/5h87ECWhAaVrjgKCNX4PgdJ0um0AplK5zXDN4mEzx3pvsNmSX/zPIfxUKZmrZCBJHEQFJLjSe6R8vaknTfGiA0unq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728461415; c=relaxed/simple;
	bh=6OlxNdWclmStA3eFD7BwTcnFpuuKsg5RM48Uu03S2UE=;
	h=From:To:Subject:Date:Message-Id; b=FfV81wdKi0KY+cRDpJ6gL+IrvVBdUOuK0SrtCniuBMcfH8aDqmhQ06Mfn458MXRR12T9/4toWh279LxFOU1DpyAiYE5p6NChGqs7QUGHG5uJPpiGZiLzT7sVNYqfbBFrBfeudDxFxacOw3cXM4xXnSfHcZ2HdFQacVOXTQiu4hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EFB6C20142C;
	Wed,  9 Oct 2024 10:10:05 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B65A7200874;
	Wed,  9 Oct 2024 10:10:05 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 00B65183F0C0;
	Wed,  9 Oct 2024 16:10:03 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chancel.liu@nxp.com
Subject: [PATCH 0/2] ASoC: imx-card: add cs42888 codec support
Date: Wed,  9 Oct 2024 15:46:42 +0800
Message-Id: <1728460004-364-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

add cs42888 codec support

Chancel Liu (2):
  ASoC: imx-card: Set mclk for codec
  ASoC: imx-card: Add CS42888 support

 sound/soc/fsl/imx-card.c | 59 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 7 deletions(-)

-- 
2.34.1


