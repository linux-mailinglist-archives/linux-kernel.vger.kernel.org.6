Return-Path: <linux-kernel+bounces-540373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC40CA4B023
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF02D8A0F93
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D6B23A981;
	Sun,  2 Mar 2025 06:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="FstbhTFO"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0681EDA12
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898743; cv=none; b=QWngsHbCUT4xXBa/EubfD/teYZqlu1e/c8QTjT42FBk8UXAp9yVYmaT6g8H6wReXPzJ8F2uX6uR2wSG3fxO0mVeFGCcBeB+A+TmjBTtTEfU+nIvJZoFxq8+3i82sGJFdClRmYdPQu7BfYlAw8Kz+EJFoybH31MH283TvG/78W5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898743; c=relaxed/simple;
	bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=grlNLBs0GJUmEDyrf37afVAf/qK/INT2ToVMBd0jYnz7Xm0a+VjfH+ZXLgyNpHa7hJYFRklDCvoa7JP7q1nCyWNvM67LRYnOF6no889Xw0Sbnu4P6EBhVZ9Lz7AnRAmtbyXydubf5ki+lM1el9sFz6fEs+KZKPL8c6V2ZQbxY3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=FstbhTFO; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=; b=FstbhTF
	OmTAKURaM12m9vM2jqzhza1dgr9hLsqLI4zbf8culj5e81d+fqsHTTcYX7NDQc3n
	zQOHSTsRgjw3GIjnEKdGt1kwDGJDrAUAnA2jIxf2as0gIkxggXs3mAth2f9GwgHF
	6l0iuShJQBlSH3ZYuzODJeIwS6WyhJbNrX1U=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnL6Ye_sNndfaxBg--.46686S2;
	Sun, 02 Mar 2025 14:43:42 +0800 (CST)
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
X-CM-TRANSID:_____wDnL6Ye_sNndfaxBg--.46686S2
Message-Id:<67C3FE1E.071810.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU-c_-DUUUU
Date: Sun, 2 Mar 2025 14:58:55 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbifgkEumfD7erXZwAAsa

Hello! Rust is better than C


