Return-Path: <linux-kernel+bounces-553665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29142A58D24
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E26D03ABE80
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 07:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0981221F07;
	Mon, 10 Mar 2025 07:43:40 +0000 (UTC)
Received: from mail78-66.sinamail.sina.com.cn (mail78-66.sinamail.sina.com.cn [219.142.78.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF68221DB0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 07:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741592620; cv=none; b=BWrzEo/L2dSuamXgoFeEBXE7mAzUX2f/vQZI2dLB8qbXQ7Bwu/AUBtR9fA80pNfTv1i+Ua+MgvftfUVTGzJrY23hSlz9KC6sus81Swfph5Q5EQm4uLSGUZmdlPwHlvvjFr7HwqSE/BnO4aAKyBYxq3Udekixo4PC1Ug+6zPFHFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741592620; c=relaxed/simple;
	bh=+ylCaPqMuBOOPYEKUzjxA2hFKkA6JCzUcwHKkGx4RDo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=fGHTlCNNuM2JQOtJV2uw9XhAoSULFhC8yu5x0LvEMHiEx/Q4epFIrOWLMQSniOEG+l2EIVc4Wq5xFlTFkzTweerV1qV8P0GUvKrIySkeb2rljr7sc5UD5k2nrQtNdjiSYdUvAlXxU+aH1M1zI0e9NNdHixSXUwVALrMi/rDQbTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everest-semi.com; spf=pass smtp.mailfrom=everest-semi.com; arc=none smtp.client-ip=219.142.78.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everest-semi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everest-semi.com
Received: from unknown (HELO zy-virtual-machine.localdomain)([180.159.108.137])
	by sina.net (10.185.250.32) with ESMTP
	id 67CE981A00004D8A; Mon, 10 Mar 2025 15:43:25 +0800 (CST)
X-Sender: zhangyi@everest-semi.com
X-Auth-ID: zhangyi@everest-semi.com
Authentication-Results: sina.net;
	 spf=none smtp.mailfrom=zhangyi@everest-semi.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=zhangyi@everest-semi.com
X-SMAIL-MID: 76F1BBFE37B4418DA964987A436D7C60
X-SMAIL-UIID: 76F1BBFE37B4418DA964987A436D7C60-20250310-154325
From: Zhang Yi <zhangyi@everest-semi.com>
To: krzk@kernel.org
Cc: tiwai@suse.com,
	robh@kernel.org,
	conor+dt@kernel.org,
	broonie@kernel.org,
	devicetree@vger.kernel.org,
	lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz
Subject: RE: [PATCH v4 1/2] ASoC: codecs: add support for ES8389
Date: Mon, 10 Mar 2025 15:43:22 +0800
Message-Id: <20250310074322.122840-1-zhangyi@everest-semi.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

> > I apologize for not responding to this review comment.
> > But I did view these review comments and fixed the error.
> > In the meantime I will modify my cc list, do I need to resend a new 
> > version of the patch to correct my error in my cc list?
> 
> Why this list uses different addresses in the first place?

I was trying to show that I have changed my cc list, I apologize if it bothered you

> None of the patches had changelog, so you put additional effort on us to actually check what changed (see submitting patches).

Can you please check out my new v5 patch, I'll add changlog to the following patch

