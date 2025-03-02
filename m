Return-Path: <linux-kernel+bounces-540213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B28BA4AF7B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B477216EADE
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D9D1DED69;
	Sun,  2 Mar 2025 06:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="D58Ssf6O"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B151CAA7F
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897836; cv=none; b=uWwQLSUwK6SaudGhHAfr58c1hgtEVWaVwQqYRkMJnSGWUQ4GdixZoediqKcTCXBPfF/fTi/tUp0IMFX5Q07+xozSUyjFWaqXQDj1uoax3UKfO/bljgsZzgsu1mf4v8sfkLnFN1Q9+AnZaWXb3W405wKxOmxC3X18wN2PdAatwds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897836; c=relaxed/simple;
	bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=sIykZHYTr/11VtPj2TMjNaPGLYl9xy6AKHB7KAh5kHE2MfHaXt0Se9tQtu4+192z95LbSuXHjvwZB0dgZZ41Zn+Dz9HU1K6w+L5fh0oMxaBQqgdK9ogR7MhIRHWVPUTVvl5sa9WLi/7LbOeinMcFh+n0W/Jf9RrUdl7kh+ct39g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=D58Ssf6O; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=; b=D58Ssf6
	OSpQ4E8PAXkt5nK9DFBMiarXfJiZ4Le9jWYw7f8aUjL5N7VpjIiw/8TSE66Fz4yD
	ss8BwV6nHlfgkCXYoMq1Ciw0XAAFnhPgwnn/hmc1zqDnYbQ5AMBlefN7vWplSCZ3
	bBNgA4skcsfZyQlGnBP+x8KbMAahgWFRzGHk=
Received: from localhost (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCkvCgD3Xzsj_sNn1nfdBA--.10160S2;
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
X-CM-TRANSID:PCkvCgD3Xzsj_sNn1nfdBA--.10160S2
Message-Id:<67C3FE23.0F01B3.16940@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUq5fHDUUUU
Date: Sun, 2 Mar 2025 14:43:47 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiihsEumfD7fHXsgAAsy

Hello! Rust is better than C


