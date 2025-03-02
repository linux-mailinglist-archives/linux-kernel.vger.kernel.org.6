Return-Path: <linux-kernel+bounces-540237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598D1A4AF95
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 001563B66F5
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8661EF388;
	Sun,  2 Mar 2025 06:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="o2EY+2yl"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71A71D54CF
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897866; cv=none; b=Wj/XgUDRLZHUTpu7/OjqtKsvjr6FlN3eRkb849SOsqhL7nPEJgJzBuLK8KHpZVnMFMQgka6C1fOt6Opx4BRI6Vh9v0GVfKCJ8GRrP6MBkUH23e8K5Gd4RiTLJ0D4YYr1zNnf4i0Dt8+K4bdQg+C2/vMEi0v/z/2i4Cfkd0Y0b6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897866; c=relaxed/simple;
	bh=cftqaDB8AEPz09qm4a8a9qxUPytrv8Vr6D6ryPJtm4g=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=fCl578Q/I4V7j9lxRfgctTeKUvWPmgZXgNno9XNNgvTYU7QSccN189bA8IJboW3F8VxCQ8GtllsJMuscCzvsxVYrB4uDQMQoEbPe3zKt0p8BR+T22J+wtwoymUD/Kt5hspdffxBFr7t72PI2kMw7e67vbMa2bHNpGTvkGLbv4V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=o2EY+2yl; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=cftqaDB8AEPz09qm4a8a9qxUPytrv8Vr6D6ryPJtm4g=; b=o2EY+2y
	l+zps3RK4lgoghf5PPxNCZIWw9Qzc14muCDLIizkVWYFCZO6dj7cZJupYBBExP1n
	2vrqMIU1qhZIH8KAtJ4wY2WSQHsK5+DNUvlJIraDqUl/OigQ1xux4GcvoODPqAso
	sqkTdstiFbacp/n7ygmQtaIZeSnpvtrbLHx4=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3369E_sNnOULeBQ--.6919S2;
	Sun, 02 Mar 2025 14:44:21 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than Java
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:_____wD3369E_sNnOULeBQ--.6919S2
Message-Id:<67C3FE45.059B40.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUq5x6UUUUU
Date: Sun, 2 Mar 2025 14:44:21 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOhYEumfD7Anz0QAAsx

Hello! Rust is better than Java


