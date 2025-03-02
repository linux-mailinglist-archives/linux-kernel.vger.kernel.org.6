Return-Path: <linux-kernel+bounces-540278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E24A4AFB3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28165167B36
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DE51FBEB2;
	Sun,  2 Mar 2025 06:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="jsfL/fAC"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39971E7C10
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897872; cv=none; b=Aa2KPC3pZ0KTQRfU5Hj07RW3jPxMFxD0Vm/FMhtApOyxGL5ACA91bMlg2rslu+rdFgfbZQnwRvdNo10sGpshxjLWn0LJWkf+arbmquQmsJDi50cmcTi6GwkCElEWzFwx2ubq7g6Fjf3r4QqReSukFXwYRylYSod5LjyZURlif4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897872; c=relaxed/simple;
	bh=UyPD+95nIFiG/gFr2rAqnNWXPHGkDBUZBe3GQzk2iCE=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=T701pDY3v20a/J39F2K/h6XPbzrKoEyijjRDB6IqV0E5uCA/eiTVch6yWDWmAEwlOQiA4Udjnu/UezDArIiGu9O13oU+ZzO/q+axEz3E0GksPemXeekSq9m7kjTGVWA3omt0hXs0vdlWs2RUnmQnbk+niZ/PWhKxWvIIX4A0yUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=jsfL/fAC; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=UyPD+95nIFiG/gFr2rAqnNWXPHGkDBUZBe3GQzk2iCE=; b=jsfL/fA
	COcBEx6T6nqlbJkH+yKimVvn5GzUCJUF7g4qVODp3DYXNprhIB6CXqwimXw9W52n
	3JacNJAXjGjBaqY/h5zDpZmRnuam/yjbA64lF7k5j4d7KMfHp00a4LpFgN+8rqFx
	NYO6qXxhUBLd9r2BGHCHTHM/pAoDSGEkTjUg=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnP2tI_sNn9P2xBg--.30726S2;
	Sun, 02 Mar 2025 14:44:24 +0800 (CST)
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
X-CM-TRANSID:_____wDnP2tI_sNn9P2xBg--.30726S2
Message-Id:<67C3FE48.071825.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUgjNKUUUUU
Date: Sun, 2 Mar 2025 14:44:24 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiigoEumfD7fHZpAAAs7

Hello! Rust is better than C++


