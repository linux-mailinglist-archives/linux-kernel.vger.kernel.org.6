Return-Path: <linux-kernel+bounces-540400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE09A4B036
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B33D8885E80
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5964E25332A;
	Sun,  2 Mar 2025 06:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="BjEp5Vf0"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7871EB5FC
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898747; cv=none; b=mLiz4ry0EzAfjYPWuTo03NGIpb0p9WbvF5JdNS4zpK3pCxkLSOMSoeZv9Y5lZNURuutx6913vCcnGeCVpOG8vF2rQvS72WH+4o7X0gU3iZ77ur1l5QeGw4EkdYpTo2DImDLdZmc6Y8Z+VK6ffHvMTR2zmr9hDdu+TO1ooIwDqj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898747; c=relaxed/simple;
	bh=PchpREbeVuSu33VarUHMnUKVR1nscKOKnSIs1Y8iilo=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=D10DUD77SeVlcbmGzYWOx7iejJHf/t91LUjW9YWcYZnnE9lb8epV2FAfiAgbD0OKPQs9Js0eSmZTYvvDMXPutCkPetLylCPyJVWasn6C7YLmgbIAbOmMSGYtYYCMipNZ8E3dtLrR9cmMEp9bSk11MpgevnNzYgIuhTyjyQXvI7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=BjEp5Vf0; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=PchpREbeVuSu33VarUHMnUKVR1nscKOKnSIs1Y8iilo=; b=BjEp5Vf
	08ENu6TGMh3WM9jZZ+okdwzX3vieBOVLRmb0b8OV5+vQ1vooNzr17Db4H+3QcT2F
	FZEWiGkCusIpFvRDSzLO4gYTFxIFPihN8urOupFzNi+JK1bV7ikaGGbv8OBWxc2z
	Rz2jr+Hw7dxyTAiPT6QX1C9L1J+W3VA6pIjw=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3r_Ui_sNntM0gBg--.41038S2;
	Sun, 02 Mar 2025 14:43:47 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than Javascript
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:_____wD3r_Ui_sNntM0gBg--.41038S2
Message-Id:<67C3FE23.066DC3.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUq5fHDUUUU
Date: Sun, 2 Mar 2025 14:58:59 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiihoEumfD7fHXowACsg

Hello! Rust is better than Javascript


