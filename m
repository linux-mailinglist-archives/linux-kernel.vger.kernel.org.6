Return-Path: <linux-kernel+bounces-273964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF7B94702E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 19:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5A38B21808
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 17:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEB31369B1;
	Sun,  4 Aug 2024 17:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEgWZuOn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF79713B5BD;
	Sun,  4 Aug 2024 17:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722793926; cv=none; b=hD4L6NedcyFT/33+bVFVl60+GWaLGXoiPMpSqhOleUmtZSeHFAc12KhxWht1Sz6K4fKZEYWD7IA2st1AYRLW2GXYE8hxcg50x5D4SXcyZhD7eNOCie9hG0zqsR1J+On1UBXYWT3v9Qq4ToUP9Kl9TaC5fs9VEKuT/dP89paWwUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722793926; c=relaxed/simple;
	bh=UawR6ZVFed6cGGNRU+ZG50gyOHGgoERASO4wuWG0GzI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=k2bVOw+piAZanLsB4LNYnPRtBJMhtpGSgN8AQkzJqlo9qcmnlp7npePbv8u5UtOobCdfz6XjuAh8uo0YCsazubKfOzMBjj9v5ccDNXTXl8zdG7Id8LW1pBpFegJdYIPVZND/T+F0mMQj80YbRLNOIZQN3SGy7w69SOOP82C93ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEgWZuOn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F78C4AF0B;
	Sun,  4 Aug 2024 17:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722793925;
	bh=UawR6ZVFed6cGGNRU+ZG50gyOHGgoERASO4wuWG0GzI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PEgWZuOn+vgpcjys17BhMPrP0c31pyrSx11JLKjut9zeVMIk8OlHNLfaq4AiNl3b3
	 0QL7OrpkWwQXF+i3FkmqJrYP9k3x21mvYZ0mBq6vpJrlCrrP6ECc8TDUPX9rLjpMP0
	 7pqnMY/UOc3wxeoa9sOJ+oKcB2KKTdGspfmjZGYeSf2jJI9yxeWpOCIoLRpPgVfr1P
	 vucpUCixC2Lvk+nP/p+ktXCdSqCcyRRglwzZOjKGDaAr7yQAxp9t9I4s1ucX+xOOJy
	 TSIdEGR9XPY+dVXTqRd4aFbouyBR0TfKMO4+At50VnLJob1cZKIcSMlhSxQ/2ILQls
	 AsHmD39Je0Y9Q==
From: Vinod Koul <vkoul@kernel.org>
To: kishon@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
 kernel@pengutronix.de, festevam@gmail.com, alexander.stein@ew.tq-group.com, 
 Xu Yang <xu.yang_2@nxp.com>
Cc: jun.li@nxp.com, linux-phy@lists.infradead.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240801124642.1152838-1-xu.yang_2@nxp.com>
References: <20240801124642.1152838-1-xu.yang_2@nxp.com>
Subject: Re: [PATCH v3] phy: fsl-imx8mq-usb: fix tuning parameter name
Message-Id: <172279392198.406224.16617087876410546053.b4-ty@kernel.org>
Date: Sun, 04 Aug 2024 23:22:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 01 Aug 2024 20:46:42 +0800, Xu Yang wrote:
> According to fsl,imx8mq-usb-phy.yaml, this tuning parameter should be
> fsl,phy-pcs-tx-deemph-3p5db-attenuation-db.
> 
> 

Applied, thanks!

[1/1] phy: fsl-imx8mq-usb: fix tuning parameter name
      commit: ce52c2532299c7ccfd34a52db8d071e890a78c59

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


