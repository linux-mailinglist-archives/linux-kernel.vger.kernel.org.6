Return-Path: <linux-kernel+bounces-540229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E56A1A4AF85
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 154293B44B9
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96D71EB19E;
	Sun,  2 Mar 2025 06:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="ovn6Eakl"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8F41ADC7D
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897866; cv=none; b=HgyIR/QUuGmQ0SuJaHneB7aBuR+BcQ9aRzCvCsCtgBxJMfuokFCSlip9kgrWXTIAjely5RZUaUxQaooBj0VnIhOO0zKhmrg3Ox35eRtt4V3UdmNYJ+OxRnEkBZ21RSf39ET4Nk3uHmEhThjDSUufLxnvn7M8nCr6OeWi1wGA2uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897866; c=relaxed/simple;
	bh=UyPD+95nIFiG/gFr2rAqnNWXPHGkDBUZBe3GQzk2iCE=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=YqVdNXp3M7mo53Dp3/NN3uX/s+HdYNdwQVYw/XX4/WSMKU2zfaVqDDYxCae34Dldu1wnmcD/+J22NyFxsDcmAe5K2hEoht7m1oa7A7fIz8g5D8EaLQnVGsbTLatGLXANiSxffUh2/yowMYiqm86DApR+SGb6aZC8CGd0igq0yyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=ovn6Eakl; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=UyPD+95nIFiG/gFr2rAqnNWXPHGkDBUZBe3GQzk2iCE=; b=ovn6Eak
	l+NI3p9mQ2YtmV5/tLlLfknxtuyygbVrpFfbdaeUn0hqHTpxQNFlSk+Fa0QTnOVG
	TXfL+qejKQI/JtWAYGbiUpAEc11SAkqR0bzordiuiclNmua5xh8lCe1RsS9dOQ/w
	/OQfnTn3d3SIDMD9a3mCcCsuztnJCeZ6w4RU=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDnPyxE_sNn2zxkBg--.41460S2;
	Sun, 02 Mar 2025 14:44:20 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than C++
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:_____wDnPyxE_sNn2zxkBg--.41460S2
Message-Id:<67C3FE44.06E75B.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUq5x6UUUUU
Date: Sun, 2 Mar 2025 14:44:21 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiihoEumfD7fHZbgAAsh

Hello! Rust is better than C++


