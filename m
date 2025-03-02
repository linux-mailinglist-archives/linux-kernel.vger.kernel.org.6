Return-Path: <linux-kernel+bounces-540356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2847AA4B009
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D19D19E022D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF881E98FB;
	Sun,  2 Mar 2025 06:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="aqVAgrCJ"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6C81EB5E7
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898742; cv=none; b=olaGWLt8AB6xoDSEo8jXQxvEMP77xUTwFOhpC73paC6VTtJ21pYW3BLhDuAFP5Inc1e9++ZVlAW31UicEZXk0ZH8OqvqPoKJiz/gFI7xKXkseR2K3vsamlIF+gJNF2uzGgLJXua5mEEWUoIpMP5UxZZCtuSR4+0nVbfVYCcfBOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898742; c=relaxed/simple;
	bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=Ylaph1UhSzhUAZk5dHm660SV/rCTUO8FlVWUFoFxt5XtH9aaP3wR1tX7GLj6QU/gL5P7JuanUS5gLjEF43Va+rDgpQfbOcrdr2Ut4G/dbrn62srxWWtovIiy1/ddDLcFYp4LIvARAVvftZSNKtvbtBsCu9KYDSlYVTkOdp5eVTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=aqVAgrCJ; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=; b=aqVAgrC
	Jo8kaL+6psh7708X5RmvCRjt6LcGvZUvvA4YX+4MrnrnEBY6Dk+1aQV1javnpRCb
	4ypfW3/3HJ/zcJ4mmnXbQzAuzLZXMh0p+YwvlvDHDF8WDG+u/bo7ZgDqw6PIOHxV
	wQ4JMGGHGrdX/kgm86JZ4HEek1cTJFnLdg+g=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDHT9Mj_sNnHT3eBQ--.41448S2;
	Sun, 02 Mar 2025 14:43:47 +0800 (CST)
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
X-CM-TRANSID:_____wDHT9Mj_sNnHT3eBQ--.41448S2
Message-Id:<67C3FE23.059B3B.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUgbAzUUUUU
Date: Sun, 2 Mar 2025 14:58:55 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOg0EumfD7AnyEQAAsr

Hello! Rust is better than C


