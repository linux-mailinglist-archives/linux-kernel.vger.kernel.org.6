Return-Path: <linux-kernel+bounces-540273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FCCA4AFBF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BCB13BAB03
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF751FBE8E;
	Sun,  2 Mar 2025 06:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="OQOEKYC7"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946B01E7C2D
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897871; cv=none; b=PTBAAOBx6aHGUTjnO1zamf3zSZbFU7vuq2KTrjlFsb27WxutVyMBEk+c3VIWstHzPGs3MDglX9yqPqOAbqQDeotM9yVzlELbSelYFU6Ad8tXKt6XWbScvjwXjIT7cEW1Te9rHZMrGx9PD8RYF/OdxhwyJOKma/cAXicsZwGXVyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897871; c=relaxed/simple;
	bh=kuanHuw9J0++yX2NZUc3mDyVR4V4BIDbLbg7VpSpL+4=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=e8MkvP+pzJs31mofSm1P9WioS5A26fnnW+BG8gGvWOfTsCXD8gpXBiNaBBDeYOF//9+6FoARn42nCXEEZoiIv8b2xbUWCSZYLWdfg+ESLdIH864KAUNj9L9FlvKdS+1DU9x3dyQWYYkWmu604/8CglNQluVPFcY3NfkovK0CIEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=OQOEKYC7; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=kuanHuw9J0++yX2NZUc3mDyVR4V4BIDbLbg7VpSpL+4=; b=OQOEKYC
	7QepTtXV0GQOCcUjh/U0409YfWHkg4v23bKrwNXuYTmohgahn/1sL1sUlULVoilC
	JAgOdgeBPdZqCASBsNr73zxyWpL8+oMnRiPCvjjfBzG40EXjp9Zz6BtB+dtc4i2J
	3LIF1tOWMW5sQtUK4URzo8J1n/RXlOkEwv08=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDnv9ZJ_sNnoj1kBg--.5464S2;
	Sun, 02 Mar 2025 14:44:25 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than Cuda
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:_____wDnv9ZJ_sNnoj1kBg--.5464S2
Message-Id:<67C3FE49.06E761.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUgjNKUUUUU
Date: Sun, 2 Mar 2025 14:44:26 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOhkEumfD7An0GAACsy

Hello! Rust is better than Cuda


