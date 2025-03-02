Return-Path: <linux-kernel+bounces-540339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D92CA4B00A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA523BE55D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4950420A5CD;
	Sun,  2 Mar 2025 06:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="OijxuC4f"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB501E9B31
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898739; cv=none; b=nBS+exW0brb7GLTkSX/FFux47s4Np+4lNufvhipuay+r/FxdPBtd14bsLjtKZDG4ua0OcYnTt+8uLuy2MkyZ9xVpv6a/YUps3XoTkaA2VAzIRfDYaPsnPOjtxsQV+If7i7TdBlC4/8mpOa47PnU3Jeasjhuye3PDTkMRoz600wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898739; c=relaxed/simple;
	bh=PpuV9J8+n9bZO9SKZkLSiMjR/byLHXwmtdk5TtpXbDo=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=pJU+5T45HPjSDEwTwNMSqcTIXgyZFqVRTlL+jSLSE+Yr1VtlJt3ybG3UkkS3pTgmIAN6t7gfDigQF9v5nIjB41LL0m/rjLzCBf3Ve33tGc+uRDLxZFGQct/glOcdG/RIY1krMtWHE/pngb0MBVapqzYauNhsdpaOlo1D1xFkOKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=OijxuC4f; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=PpuV9J8+n9bZO9SKZkLSiMjR/byLHXwmtdk5TtpXbDo=; b=OijxuC4
	fDXNTdcjtXDjCWzRUELL1pn62i80NKikPSueTrF1n96w2MdaeNRJ6zhKk0bLxL+9
	IewhY2N9XMmZ17+n0yZAJypF9BSp3XvL/87ZqK0Lum13gNKv2h22rQu18O6Do1jk
	lHdsaPc/yPWxQAYPnagh+RZRaVO2Ho+lKXdg=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3V6wg_sNnjDZkBg--.46610S2;
	Sun, 02 Mar 2025 14:43:44 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than CSS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:_____wD3V6wg_sNnjDZkBg--.46610S2
Message-Id:<67C3FE20.06E751.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUToUqUUUUU
Date: Sun, 2 Mar 2025 14:58:52 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOgwEumfD7AnxxwAAs-

Hello! Rust is better than CSS


