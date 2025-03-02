Return-Path: <linux-kernel+bounces-540331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E26A4AFF8
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 660EC3B7E6E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401FC1F1534;
	Sun,  2 Mar 2025 06:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="X2onH8XE"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015641E98FB
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898737; cv=none; b=GAztH+dOAu2djAauEnvsHQ5A/Zr/u41lc91ykOFsbJgv6BUNdfUCyohjuF9wKvuWHNosyLFoAekBgwmQu1XeAkeGRbogRSy6Ub64iXZUsNMEVVQ6auywyIil3zKGL7qrplhJWaD4s8NWkIOBhLuWjdEr4aGzujb3y0FlKmkgd6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898737; c=relaxed/simple;
	bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=iM7GJtY7L4H0pFTQj2dStDhFMhJ/h612ePZ2e0Xe/6wAZUBkwCIB61vvbAaroDx7cdfX7M5NH+BF68MKtd7HRzDtJLaRhJwrdOCVXRFB+nGeqidWXhp7sxwqAkwBR2ies8WteY/7v3z+s5Onx7m3Uv7ieweJ66fzGfwbX61PISA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=X2onH8XE; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=; b=X2onH8X
	EbyxY5qRL4XnN8w1TN0Mq5dKlllu2wzSl0UodHH+SFfeRMuGE5oFVRcx/ObQpUb/
	f3TGaBkH9f11BrO63GbduM93uHg5SB69gRDHIG6k5+0JRkn7s9AloBrbl4GQqMDV
	ZGvWtu39Zcyj77106WIBXe2+okoaVajK6qPc=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3V6sg_sNnQ80gBg--.29434S2;
	Sun, 02 Mar 2025 14:43:44 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:_____wD3V6sg_sNnQ80gBg--.29434S2
Message-Id:<67C3FE20.066DBD.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUToUqUUUUU
Date: Sun, 2 Mar 2025 14:58:53 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbifhMEumfD7erXfAAAsb

Hello! Rust is better than C


