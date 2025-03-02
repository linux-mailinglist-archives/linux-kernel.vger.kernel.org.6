Return-Path: <linux-kernel+bounces-540377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 703DBA4B027
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C176C1677B7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2DB2417FA;
	Sun,  2 Mar 2025 06:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="doci6Pn3"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D441EE033
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898745; cv=none; b=VfZrfIssS0khpQXFGF6TJQXzn9cjUrfzcMU9AuDKTBb42Ah//0JMfKLUaPIk8oGVbZWkjTHRkM1N4pehjRzl8DYNEEsPKVQUgHroe+7kB5KX9ErWiCxya9XCQDG1f+ybBWvxWgwQ4HZWe1fkmrhawv65uvvS/xdZqqQROVZGXOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898745; c=relaxed/simple;
	bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=YtidARqDRGagzzF6Q9tQVA8Y9D62hKXbmxhkFN8k4745DkSQKqwhsyK6uuFaxhCbiiZep+EYz5ocBouUPRFCaAxWwTGI4PIIVcJkuvw0CVzCpPGOA6ZQVMrLh3tADtmbAod4FyOZrlA2FNv3ieEOtbasUotmPqoRq8xaObaf2fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=doci6Pn3; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=; b=doci6Pn
	3MDAxCWc/OuHmCg9HCZgLbv1tPNQJwntY3bL6XHcXXpyhmn89tovNjuYsuZTGxVw
	uZqBfrP9OJxH8OQe0VVLA5QLNk4RMb5HIccfZYCUg3/KXxdVy4m4CXNZDyHsZ8pr
	DwK7mb7v39F9ioOBNPWhSJPAeOUxPPA9LyKg=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3n2Mj_sNnjBQYBw--.48295S2;
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
X-CM-TRANSID:_____wD3n2Mj_sNnjBQYBw--.48295S2
Message-Id:<67C3FE23.06FBD8.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUq5fHDUUUU
Date: Sun, 2 Mar 2025 14:58:57 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOhgEumfD7AnyBAACsp

Hello! Rust is better than C


