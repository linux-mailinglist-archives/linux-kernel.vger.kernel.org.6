Return-Path: <linux-kernel+bounces-220989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2229690EA5B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09CC01C21611
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FFE13E3F8;
	Wed, 19 Jun 2024 12:05:56 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698C413D242;
	Wed, 19 Jun 2024 12:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718798756; cv=none; b=JeOcrXUqT0uPL1xwfC0n+jehVX1P2OL5MOawojLMTJ9/JZEQnRrFz6mYfSo8biqbX621SD9FYlyYQXQrJBoTFPdu3bxvs+u6asv9Gk46pgkG4ZG50euh60e36Ns+IftX8Z4Ugh4AzKYP5wdusEP1EvIQTm7uBmhlttqiptAZDr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718798756; c=relaxed/simple;
	bh=a/dGg86bA0m+Ua7DIL6U5Hh65Z7ekXcYCH9oCM0fDtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bjPqfnQx2lJXGRS28EV7sGCqDCtttRdU6CHufo2tiO5uFkSHYN7gG1EqJW2MCSbXxO4mdwtF42ZNNXpibiLKqFuPy45p7WbX5mja/pFA14V0pYmw5sVdBZDESbbz2HEj9p0CnDAPZtaqtK8VFLHCkpRZKWAktiQgEaFnmcV/LRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e8616dc.versanet.de ([94.134.22.220] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sJu4D-0003Np-2n; Wed, 19 Jun 2024 14:05:33 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Chris Zhong <zyw@rock-chips.com>, Zhang Qing <zhangqing@rock-chips.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Furkan Kardame <f.kardame@manjaro.org>,
 Michael Riesch <michael.riesch@wolfvision.net>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 1/5] dt-bindings: mfd: rk809: Use correct compatible in the
 example
Date: Wed, 19 Jun 2024 14:05:31 +0200
Message-ID: <10483007.DAOxP5AVGn@diego>
In-Reply-To: <20240619-rk809-fixes-v1-1-fa93bc5313f4@collabora.com>
References:
 <20240619-rk809-fixes-v1-0-fa93bc5313f4@collabora.com>
 <20240619-rk809-fixes-v1-1-fa93bc5313f4@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Mittwoch, 19. Juni 2024, 13:23:30 CEST schrieb Cristian Ciocaltea:
> The example is not able to actually test the schema since it uses a
> wrong compatible 'rockchip,rk808' instead of 'rockchip,rk809'.
> 
> Use the correct compatible and drop the wrong properties in the
> example section so that dt_binding_check passes.
> 
> Fixes: 6c38ca03406e ("dt-bindings: mfd: rk808: Convert bindings to yaml")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



