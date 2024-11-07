Return-Path: <linux-kernel+bounces-399179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 537A19BFBE3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84F3C1C21EBA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 01:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C14FC12;
	Thu,  7 Nov 2024 01:45:20 +0000 (UTC)
Received: from cmccmta3.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA1F28F4;
	Thu,  7 Nov 2024 01:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943919; cv=none; b=oPHXE6Z/l2H4pn9yhZ7T23P9vPoHHg6ApaOsmQ83+DSMfUspw/ft9AsQc5L5jBQ6rQLdR9OoL+NsCZf3W+/2brmFMLsap1jz/Nmsm8fk1IZsA1rcJZJSY+ZZj7E80wcK6n1dw1ybmib0BXtLNJMzI/dhea7kjzPgFOWicLNZxIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943919; c=relaxed/simple;
	bh=WDGnKAyMbvjak0laesuk30Fq8P+k3o9jOmQzmXmNl2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iX8sW5KghD0R0LreHIewIjy5GFJ9Bxp+oPBgLBnxKp6sWKtdXR+qtDQGJlLeg84tfDaXWiGmxMCWogpxkbAfhZwaksMgH7E1iz+E9SAtgistNCPJPt4OM6F49Hoi9lwODT0xeC9OTXAm4G3Az5rFUqWNBWpyHMHajm/epQhfpPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee9672c1ba7a6a-e8a7e;
	Thu, 07 Nov 2024 09:45:11 +0800 (CST)
X-RM-TRANSID:2ee9672c1ba7a6a-e8a7e
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea672c1ba6fbb-49cd9;
	Thu, 07 Nov 2024 09:45:10 +0800 (CST)
X-RM-TRANSID:2eea672c1ba6fbb-49cd9
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
To: olivier.moysan@foss.st.com
Cc: arnaud.pouliquen@foss.st.com,
	broonie@kernel.org,
	lgirdwood@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	luoyifan@cmss.chinamobile.com,
	perex@perex.cz,
	tiwai@suse.com
Subject: Re: [PATCH] ASoC: stm: Prevent potential division by zero in stm32_sai_mclk_round_rate()
Date: Thu,  7 Nov 2024 09:45:10 +0800
Message-Id: <20241107014510.211654-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <f2d3778d-5fd6-49db-b418-b5411e617a0a@foss.st.com>
References: <f2d3778d-5fd6-49db-b418-b5411e617a0a@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sure, I can submit a new patch with specific tests and error messages added to stm32_sai_get_clk_div().




