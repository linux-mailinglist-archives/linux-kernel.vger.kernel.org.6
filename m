Return-Path: <linux-kernel+bounces-540386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE66A4B01F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AE947A7680
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61312459DA;
	Sun,  2 Mar 2025 06:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="B+bY00Wa"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036A61EE7CB
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898746; cv=none; b=F5KZalKMwYpXuUwXxaza1HpijO5YggpS4MkPLujbROooEh5Cvrs0jfncFh5c0A6pMqz3adrJNcOkKhZv0Ctjq+gpsokQt8ifDEGkf/Wq5uYYcz4zWdco4VbQxeYGgEmxyqCtdRiBtBA0qMW/7xaC9EG1t2JeClcRq58VuUXJryU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898746; c=relaxed/simple;
	bh=U/wIYARQ7kbvgXqE7DzmguflZ6ifai48GUe3iGqWynM=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=ZB1P3ijkNsc+de/C/xVIreKgOgFti+xVYixfY2b6GwgF2ChzOoLh7Nl5iuZLjQT3TqPof4VQVZbhDSsD4W/iGA80lVAj31WmfFPWLi7//cxRPi3raLWDFo05qDaWalezW1bgE9nGHgQW8Kz+zaitqtYY1KBUj5K6m6wDlnUUqlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=B+bY00Wa; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=U/wIYARQ7kbvgXqE7DzmguflZ6ifai48GUe3iGqWynM=; b=B+bY00W
	a+Q66bSgZdU4lX6d+MxnW9A/RQQBlTe6ugfZ+jA0DJL+eeiX9HN0GGYewB2cUjub
	QPwv6lRwNstUA9aamoBzg1BjHtKLendpqXU+XAS4zDDpCrZNqNI/U8rZK0PpGArB
	0aMVSR6I+ZNiBek7bmz7A1qaKLp7w4GREpic=
Received: from localhost (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgDnH2Qh_sNnRh4JBg--.57042S2;
	Sun, 02 Mar 2025 14:43:45 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than Swift
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:PykvCgDnH2Qh_sNnRh4JBg--.57042S2
Message-Id:<67C3FE21.0D9049.12474@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU6TKuUUUUU
Date: Sun, 2 Mar 2025 14:58:56 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbifhUEumfD7erXgwACsg

Hello! Rust is better than Swift


