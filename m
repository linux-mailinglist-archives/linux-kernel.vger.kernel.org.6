Return-Path: <linux-kernel+bounces-405059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B61099C4C7B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 03:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 689621F27628
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 02:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745F0207A11;
	Tue, 12 Nov 2024 02:16:46 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D81205E31;
	Tue, 12 Nov 2024 02:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731377806; cv=none; b=Nb3bmX+PWEB+A1pdC/81wwwJoh7aCA8KIt96nBku9nm0OczcXCPgsF4nM/FIBkHlN6XsVufzrAiIxX6zoTRqJ7GDpvf82T8UDVnAV+0hsAq2uSvsvR4u57W31lUmpR4BdZpnB5x49BJ2qlDIIp2nyk29Q+0u2GF/+e5lZm4ioz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731377806; c=relaxed/simple;
	bh=Q7Zggpb2kQXhqY8bq3iobXEkDeM8mW59zsvT+5XFnkk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EZIWXvOIlcJXiiDzfFHnYRYUQpn7rmZ1EaMZxCh8JEWpXzdWwsW2OjC/p+eo5hPYaHTFagYq+q8M44KG8WfArlW59tmLTWj+bIFk7KbMN+SyUkje4MKHksz0K0reQjdA5chbuXYNmuqizjsN53xDrt/J1sbwcvkqoXlETqK1WEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76732ba7f0b9-0a0d6;
	Tue, 12 Nov 2024 10:16:33 +0800 (CST)
X-RM-TRANSID:2ee76732ba7f0b9-0a0d6
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66732ba8055d-4addb;
	Tue, 12 Nov 2024 10:16:33 +0800 (CST)
X-RM-TRANSID:2ee66732ba8055d-4addb
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	luoyifan@cmss.chinamobile.com,
	perex@perex.cz,
	tiwai@suse.com
Subject: Re: [PATCH] ASoC: amd: acp: Fix potential null pointer dereference of "adata"
Date: Tue, 12 Nov 2024 10:16:32 +0800
Message-Id: <20241112021632.279817-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <ZzIUJ0sEm-Yw84vJ@finisterre.sirena.org.uk>
References: <ZzIUJ0sEm-Yw84vJ@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello, the current code has already fixed this, so the patch isn't
needed anymore. Please just ignore it.



