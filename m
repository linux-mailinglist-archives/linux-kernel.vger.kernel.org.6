Return-Path: <linux-kernel+bounces-548973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8725AA54B9A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 286D61897EDC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED5120CCF3;
	Thu,  6 Mar 2025 13:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="0svrTxlh"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B95D20C499;
	Thu,  6 Mar 2025 13:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741266577; cv=none; b=PhpNuHALItQxhaT3bwUdUymROVfcS+g6ZwypU/QdtxRoo/m8NJt0oEtD5o4XBFWffB7I6bZnMGto1a7PjAuTLB1dBnPAr+DIZi4LQsWOSWI1KlgdQ7ZEUwk0Lr78yxH1tN4YvdqMmjOxPFa76S97rArmNY8G5IcHfaXKt499TFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741266577; c=relaxed/simple;
	bh=1CGvzJ7H3T4fZQ85LAsVSBOIIY2J5090hnEnT8UjA3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l0lZuJsGKvT3Lab1OcC2KkyWTcPIp/zD82W8bwT6P/amZqLVNOhQ/jlPYWMYpu4hV7JstiIJPDCSuPWF8LYn9SEqU90w7G68MtkYc1ZvX4jDVCmawzY33SkqriII/YK7JAe8/mjIZQ/H3LGMY+1Q+5A2zScJb8Cu2e8fv4nHOKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=0svrTxlh; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KfevJUMvlkYaiwWPH0v/jOLdrYSk6S1xx5iNuGnoYDk=; b=0svrTxlhNNIVme+4UfyrOlWYMB
	5p0qzLwWeudr9sxtfeG2v9ShCEUMrPSDdh1TMjfP7iB2j7Z4XcGjVb5CWOtt6mPjdim8xQR5BgrP7
	Zt6oKedkl8RolRZDyw5HKmTnkPsRDwPui9/qUOn+aW2CafAUprYUWsn5JM0zdvrgGhuYLWAqReNsX
	cID6f3+oomXKrTnnabtV3tjy172XGATbwxy3zoFaVpzEP5RS3b5ZwQggTxu87X50UV92eLRbZD9tF
	dJ6dyBJNnigrITtZdZZahDnh0OYtbEjusVGd6YFLCW3/viUAzl+TbV7VrOxfbDfEZ5YrCsQ7TZin2
	3wHszQbA==;
Received: from i53875a38.versanet.de ([83.135.90.56] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tqAye-0003Cs-2N; Thu, 06 Mar 2025 14:09:28 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Andy Yan <andyshrk@163.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	detlev.casanova@collabora.com,
	kever.yang@rock-chips.com,
	krzk+dt@kernel.org,
	cl@rock-chips.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Enable hdmi out display for rk3576-evb-v10
Date: Thu,  6 Mar 2025 14:09:23 +0100
Message-ID: <174126656184.656541.9194102170806137461.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250305025128.479245-1-andyshrk@163.com>
References: <20250305025128.479245-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 05 Mar 2025 10:51:11 +0800, Andy Yan wrote:
> Enable vop and hdmi on rk3576 evb1, so we can get a display output
> on this board now.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Enable hdmi out display for rk3576-evb-v10
      commit: 7641678ecb0c242498e2a3b2b0621961653a7c2c

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

