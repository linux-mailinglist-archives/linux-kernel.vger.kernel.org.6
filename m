Return-Path: <linux-kernel+bounces-540403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 313CDA4B04A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 211CF8A324E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3CF253347;
	Sun,  2 Mar 2025 06:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="cQqIBU13"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC041EF361
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898747; cv=none; b=UevqIVY0dujOrdnsrnKgJzw6rvEAKL3BF+E+Bj/6f8CWJKj6tduknGXX5o8SRpnX7/1HYzA5/wg8oy8kCfn8GkaBG9/XY3VeTv2wYP4vt+KdcY9onefsVwX9rSzb7kShj/jgiDeBr9/n45/Pg+/al4yayVVFzG3zLicGni7mUrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898747; c=relaxed/simple;
	bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=C1q/zDXhK4y0Sc5HnD5mQzG1o+b4klm+kLMggc9SuatM6ShTJ9X3rNR0mISCATDD3UXiMPisu2iXqcPh5rBpLK0PruPHm66YNpHvZtTNEZevLPyCQxBUT7LVjGYee7J5leFXS/RjyPZeQCVup3ZKRdOLOQnghgDpywH5qM0vjrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=cQqIBU13; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=; b=cQqIBU1
	3sI+hTEMN+xZ7/tFX9NT4gx72WunFfFd/S7jYqLx4DIYuLFBJ0WDGQNFzPEj8tjP
	VqOnsTtbOGEROJ5Bddl/TFTi76yUI10HJP9ReaFpInJXN8QyrshxtYnDbvj8wMn/
	eFM38Hjj0+r5lHV8tw88CY1ayGakZufcYydM=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD39z8h_sNnxAAgBw--.26868S2;
	Sun, 02 Mar 2025 14:43:45 +0800 (CST)
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
X-CM-TRANSID:_____wD39z8h_sNnxAAgBw--.26868S2
Message-Id:<67C3FE21.0684A9.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU63C7UUUUU
Date: Sun, 2 Mar 2025 14:58:58 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbifg0EumfD7erXlwAAsu

Hello! Rust is better than C


