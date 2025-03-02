Return-Path: <linux-kernel+bounces-540365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E09CA4B032
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9EA48A0D61
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B15723958C;
	Sun,  2 Mar 2025 06:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="f5w7sHnX"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34B21EC006
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898743; cv=none; b=BnJzDyj0cxnYWmXcPA9n82Z2/CuGavOU89UJapKF7rDnF/JbZsbN0o9SFujev7uoExWK8dsFviyM4sAMZFfh5m+qIzv/hBEh7ujgsG9XU7vTcYVIpkXwG/XUlEf7MkMPJYE8Gskdf7y9fLchyq7WG1vn13cdJXSNJqZS+gMipsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898743; c=relaxed/simple;
	bh=PfixNPQ/uTp/hFvZCGY1TVY84A7zL5WAfQIAbeeaQe8=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=n2JLua60uIzHHuWg/K+k/ru7nFh7+F3RvjP7wyHFoPC+LvSgSuBUz/f23W4UWEeQEj4xa0W50UIuf0Gsc5EpwL3+87cNdgloX81c5WaDN3W7nFbXuJtpu1yDJjtVrSdjKM9duEgug5gTQOKSVxedzAs3ccnVTXlYajUbQNm5CDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=f5w7sHnX; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=PfixNPQ/uTp/hFvZCGY1TVY84A7zL5WAfQIAbeeaQe8=; b=f5w7sHn
	XDgBvnzPlj9AqavkrS6S99QAqFqyv0SOI1fGNIXdE069jddkv+9f9TeKtSddydo0
	3qjA6eGd84z73DuX/73eyFKI5Mr/RW6HI7W4m2VpxEGA9OGSHawn0djDh2q9OOmD
	7PnJxvITd2qhOMl8rQbnj01VQxNKYW4WeIII=
Received: from localhost (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSkvCgD396oi_sNn9EJhBQ--.4563S2;
	Sun, 02 Mar 2025 14:43:46 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than Python
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:PSkvCgD396oi_sNn9EJhBQ--.4563S2
Message-Id:<67C3FE22.0B5A67.19577@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUgbAzUUUUU
Date: Sun, 2 Mar 2025 14:58:54 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiig4EumfD7fHXogAAs3

Hello! Rust is better than Python


