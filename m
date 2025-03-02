Return-Path: <linux-kernel+bounces-540266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0989A4AFAC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF0C7189B5FC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C801F4722;
	Sun,  2 Mar 2025 06:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="kyu70TKJ"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C61C1DF968
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897870; cv=none; b=IZL4LzvwSEZitKWxahXOnKugQFmSup0Dq6mUuIndoM4MZkFvvYtJlwtJvFda9KGzKKbUEzYYvYX/f+7hYiA4WFUUQ0v/dA1P6t37s58vz6WZY50kz99kwFxUHNZX8PbrS4TQ+xrNTGFsS2g0uXBOns+Nv4Rp7awtTZQsUYPrYRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897870; c=relaxed/simple;
	bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=LgBzuaqTxaea/r+epsmXI1Zk4JnTA15jGAD5xYHl8i0iv3BII4/gvbJzD8lnEin+XPSVCvoFkElBEHf6FcS5xEnhJz6wdzZeg1TJa57mEiPKnNBBqWjy/MjS+f4E5VYFv0glINhQkC9WENlWJcIlzc5WlnIK5IdDdW3z2KYTS8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=kyu70TKJ; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=; b=kyu70TK
	J3HxxElG4mNGq8758OKGwcjWKCteZcCgww6hVlCgXVr/IziiuArn3hTgb2W+KUkE
	Op0+ovA1ZFJnb9uCLmootye/CH8cikIV/N0Sbl0SfhSnHZ5iTINqEZeqCOdz0qy9
	8NmpIj+4VYdZSZXD3RZTb8iF/6PmB6rRLTn0=
Received: from localhost (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSkvCgAnH_ZH_sNnZUhhBQ--.6574S2;
	Sun, 02 Mar 2025 14:44:23 +0800 (CST)
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
X-CM-TRANSID:PSkvCgAnH_ZH_sNnZUhhBQ--.6574S2
Message-Id:<67C3FE47.0B5A75.19577@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUgjNKUUUUU
Date: Sun, 2 Mar 2025 14:44:23 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiihYEumfD7fHZnQAAse

Hello! Rust is better than C


