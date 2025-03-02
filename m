Return-Path: <linux-kernel+bounces-540274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEC4A4AFB1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01C7316487C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8431FBE8B;
	Sun,  2 Mar 2025 06:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="muH6cc9G"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C801E5B9F
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897871; cv=none; b=HU0gCLf4cyaMmbbiAQ9FDB+FylZnFfJelWptnuIykZK/xopRme0Wn8oPdJK7yQ0Xy8Fq2EoUQZKf3kR0yHPD5l8FuJ9DgQbY3F3H7oNt7kJyduSUAbkrS0WnL7qIaks3nRgP/G5xCCMR7yWN9UL8CYduHfKCZikpbiXE/qhg7vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897871; c=relaxed/simple;
	bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=EFt2LAuqa36XhnC1452nWdcEgu6oQSIRMWtJsj1j5NpWf3uzGT3MK47YfqTfW0Q2nkXotiv4lppyALtDv4X/aK88ePoxl3bCCMiJxMMUcG3qtZiccMuBtoCM9CafZsS+TlEal2Af1hMH6UigYIpBTnVUZNv+wfLgJ5j1VO5yMwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=muH6cc9G; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=; b=muH6cc9
	GiZFtmP6DdufGvtKMAlOwMdDPcPHWkoFpUIpGj3r7bMVo2K8X1Wl44M67MNLj3ei
	pDguvCdCmB0wWi0Ry8bm/2P53pXnCTEe5DlR3TgL10o56rgSjXevAea9mtPJE5vb
	v0zlDH6++5nPHUTH0b0ClbYYjM5H0MWnZHbc=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD339BH_sNnTp67Bg--.59566S2;
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
X-CM-TRANSID:_____wD339BH_sNnTp67Bg--.59566S2
Message-Id:<67C3FE47.070460.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUgjNKUUUUU
Date: Sun, 2 Mar 2025 14:44:24 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiigUEumfD7fHZnAAAsM

Hello! Rust is better than C


