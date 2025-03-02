Return-Path: <linux-kernel+bounces-540367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7357FA4B024
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628E83BAD0F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B61B23958D;
	Sun,  2 Mar 2025 06:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="adAVgT3I"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075C81EE7D5
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898743; cv=none; b=J31GXSSViP9NfK4rY2uQnjiHNJhdSvkkfjtaQOh+Z9rMOcXgbOSeVWWbSlfLopmwBeEj+dXqboUhUDHjZsk4DqagUOPqZ3K52175Rf8vIlN/Hi0N3C+LNWIOORhWDxuiPhcdLWg6iWXk+ldJ5z8JI6K/jgcOVipwlgaux9i/22M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898743; c=relaxed/simple;
	bh=U/wIYARQ7kbvgXqE7DzmguflZ6ifai48GUe3iGqWynM=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=J34JEecFoZf1BwljqbUGvDxS8siv0EbNsNySbheer06urVCKF0TCtnK+T7Y3+0QndHgFxCY+t13o3zlAWzbNTiGIVtiuNI5Tw9mSB4iR3ejISunITx+MP0F+yL26fkTEFXIPhSqKrMfa+kRyl322JO3NJmYvpXQwK5+lyUIlZTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=adAVgT3I; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=U/wIYARQ7kbvgXqE7DzmguflZ6ifai48GUe3iGqWynM=; b=adAVgT3
	IxA74yPjE6SBLikU5hKpDvZfCQrBFLH8oFWl9tZyjq6KvGjpsmSSIh2oTzT8EELY
	5gy7ZWEGh6wZL7sDOHDFg0d28Q+j0doW1KDa/MDtlEcY9zWWgI7pxnu9UqIMqCmp
	gP0RErvpEVIJ3nw0uG4A+BXqlSfBxJriBo6s=
Received: from localhost (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgD3v2Mg_sNnMR4JBg--.57020S2;
	Sun, 02 Mar 2025 14:43:44 +0800 (CST)
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
X-CM-TRANSID:PykvCgD3v2Mg_sNnMR4JBg--.57020S2
Message-Id:<67C3FE20.0D9046.12474@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU6fOzDUUUU
Date: Sun, 2 Mar 2025 14:58:56 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOhsEumfD7Anx0wAAs8

Hello! Rust is better than Swift


