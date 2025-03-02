Return-Path: <linux-kernel+bounces-540319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCD5A4AFE7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40FC2178D3E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162E41EDA1B;
	Sun,  2 Mar 2025 06:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="kRWAnabW"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6F31E32CF
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898735; cv=none; b=WLHQ10J2+wIETT3iFNOzZSRP0cOYqV+H0CAbxI7nHxzM7gjP0LhsjU8d64H3BE+gyBqe3eeF2uA2mG4H1BcSxQag5k7k9s3LYBcNP76KF8vYe/v5oWlhThIJXZUo+UDiWWMuM1Dr5ztSKl5SgsitFaTIFM1rp7K+cFRDa/PA/kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898735; c=relaxed/simple;
	bh=PpuV9J8+n9bZO9SKZkLSiMjR/byLHXwmtdk5TtpXbDo=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=m1shH/JLkSZb2akMb5YhCGpuYKwn02U0z6c/s34cosWZnoB7AOQD2NxDclGMEAkO6mtZgdCo6P5b3cx/gkt/Zl9dlwAynrldqa3vikZ2lRWkcILq91+rsJzFyizPcehQQG+qjZ41ves7KnM8zhUrQIY8SMRvD49CetfWnGsxGc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=kRWAnabW; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=PpuV9J8+n9bZO9SKZkLSiMjR/byLHXwmtdk5TtpXbDo=; b=kRWAnab
	Wmp4l1DkINVT+CErojma9ZFPV8H1wKFP4VtvulYEyLzs+4UOeenWIW8dNOcaloB5
	eg+LJtXPlEf89giTUE1tg9mjU+kyYE+/YxrC84cbNaO+azqEV7iZV0uhJpGaCAy5
	SPzxX+XFjSN7eNKGXjwE7jPkExJ97XuAnXc0=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDHjyUe_sNnQrtZBg--.50486S2;
	Sun, 02 Mar 2025 14:43:42 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than CSS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:_____wDHjyUe_sNnQrtZBg--.50486S2
Message-Id:<67C3FE1E.06C8C8.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUTAhlDUUUU
Date: Sun, 2 Mar 2025 14:58:52 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbifgIEumfD7erXZgAAsQ

Hello! Rust is better than CSS


