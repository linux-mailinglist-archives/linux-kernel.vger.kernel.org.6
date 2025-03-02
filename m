Return-Path: <linux-kernel+bounces-540252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DA5A4AFA2
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 743191899745
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8DA1F416A;
	Sun,  2 Mar 2025 06:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="oySWRi24"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFCA1D63C2
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897868; cv=none; b=BRCSQoDh/QV1LW8wsFH8J7W63WxofWCt+qF9fV1mRBJLmg6/5nrdFQtVkFm0gYSDYJIN5fwPleKQev9wPGLbdMqrUWPcQB6dM3X/vyKhmP2D2X2l0QtL+TD1Cmzvl6VR0wMnjdXY809c7GcLU0BppmUMiQBU4G4Fnw22CksKKvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897868; c=relaxed/simple;
	bh=m3WWx7WaxOLxHF4l3ehA7ZpOfcH46DacagbXvgNtOUU=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=pJO5KwdL0hZw0qH88YM4EDjZsvdQ6RYbEgetjJ0FiYjt+qZ2ZSSiL0KDTwpyCFedapnjDMEXsIbHCzcd0Q5/qcz38GQEHtbOqG5NFQjFftOwFwB/0iJjYAxqfCYJAeQuCu/wIgyuv1ucO5FXZ2De11i0DtdmVP0OIV2hF+8gpUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=oySWRi24; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=m3WWx7WaxOLxHF4l3ehA7ZpOfcH46DacagbXvgNtOUU=; b=oySWRi2
	4mEbkEfZPtru4wTYRcnAf3f0boqgEj467WKV4woT4ZerXUfEuDnF+zKWxsgJCWf0
	vnRy4e7fPLPX54UVp3xh5mFWa9DaNArLJe5+8d9Ac/PgBnJeuIn46nXGoKUWRk5K
	++twFuDMsQaA/FS3UK7yrv2qJglQx9AKZHms=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3r_VF_sNnfdMgBg--.41057S2;
	Sun, 02 Mar 2025 14:44:22 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than Golang
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:_____wD3r_VF_sNnfdMgBg--.41057S2
Message-Id:<67C3FE46.066DCB.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUgjNKUUUUU
Date: Sun, 2 Mar 2025 14:44:22 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOgYEumfD7Anz6AAAsY

Hello! Rust is better than Golang


