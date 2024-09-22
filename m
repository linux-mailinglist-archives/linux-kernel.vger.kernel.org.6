Return-Path: <linux-kernel+bounces-335103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EC897E112
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 13:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B916B1C20887
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 11:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E725B1741DA;
	Sun, 22 Sep 2024 11:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="VmbmYF+r"
Received: from smtpbg156.qq.com (smtpbg156.qq.com [15.184.82.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480523B7AC
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 11:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.82.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727003943; cv=none; b=Qq8ossdR5H8NiTAjqlyNkmyLRYHGcduaVWA4AKn9G08ebmgQ6HLUJUDWSU7mJbBcW/oZkeZ/nz1lvDcRTpGs+8tIr0T5RS9rqz4QTudupaEtCjd4lY+aLDXlq9YnPw5BiFzbbbc4q32SrOL8BVVX13yyi6U2JA6E8BeLU5K7ky0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727003943; c=relaxed/simple;
	bh=+b8TCmgo4kg3HIrziW3eB7jZ+VKGJLIC+EVu8Bb6rHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dLFrxV5EnB5ZO46ts7NgmRz9FcXE7/5nXcum+JUv2LItUxBaDHtlBHSFJI+cL/sgVBjWNbutz6rondVPTt7zwWWbTtL/pz5TdC8m9e6uJKyc6pH5I/Yt1L9GaQCfehw3q/WGB2XQ4tyJBhtzQLveTKWRPeyTiz9kYLF1bzIjwik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=VmbmYF+r; arc=none smtp.client-ip=15.184.82.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1727003927;
	bh=7LNHQS6FiM7K8IchSuigPIgUhPFUUDLZUhCpdAPCBpk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=VmbmYF+ruAZNfEhSMT6BBYHvnmTh4VXvMR0HwAdJtAX41xZGN+5v7i6PvKtA3thX5
	 6NooqKEor+hqncPvbLC1vYb5Pk9Dhr0PqXQC5kugmAovDNIBdseShS9RzRrsJocbX2
	 asOvDoADdgsVhGuDhtEDopBs1Ty70St36GioHxFo=
X-QQ-mid: bizesmtpip4t1727003917t6l9vcw
X-QQ-Originating-IP: p0oKu/gXTzlWj8kzIXlwbR7qXc0s4zPiFpVJIYIkoig=
Received: from avenger-OMEN-by-HP-Gaming-Lapto ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 22 Sep 2024 19:18:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3263834181954028634
From: WangYuli <wangyuli@uniontech.com>
To: wangyuli@uniontech.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] treewide: Correct the typo 'accelaration'
Date: Sun, 22 Sep 2024 19:18:31 +0800
Message-ID: <7BF34BF48048052E+20240922111832.441807-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

There are some spelling mistakes of 'accelaration' in comments which
should be 'acceleration'.

I was going to put all the typo fix in one commit, but other developers
suggested splitting them up. That way, each subsystem's
maintainers can merge just the changes they need.

Signed-off-by: WangYuli <wangyuli@uniontech.com>
-- 
2.43.0


