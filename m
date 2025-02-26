Return-Path: <linux-kernel+bounces-532803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D82A45266
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42E2D168F03
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0336F19D07E;
	Wed, 26 Feb 2025 01:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PZfjUbaG"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EC91422AB;
	Wed, 26 Feb 2025 01:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740534622; cv=none; b=W8AXz9tCX1RHNvXr5iu4VEx2k6LBUptTB6m7w4l79Q/GpWf/okNwBWDC52/0RTt/R07Msyu3JELa3Jh1261j1uhqo8tTCML+ywvp1q3A77oZsRf80N1pNzSRNi2wrTTnjkR4X+dacjE2lWiGY9efDsIErkDpf9uI7DW576GsOvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740534622; c=relaxed/simple;
	bh=Ebk5UJqAckcjlrat40CiVIFzj2zctaft4PTkTjp7Ga8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bmJxn+uua3OrCITZE4BesmLTCa0J/dAqUoWMEAZl8nhsmjvEewzlHwt03oOx5JRG4p7aTarEI1k+E+WEUkrDjMoFJtVSTG6fH9gdwHSVslz1kq8sI3FsRyfDSMaL7kJAl50cPtPh1Smm6YY1Zo1hFVClXzfoXejBBWe6luZDXFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PZfjUbaG; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=4V1Ta
	U4tjVbNqwDYy/043DM6DZF0KiXjCu+lG+D4nPs=; b=PZfjUbaGUZBTI9SyLY1e8
	xxTHY/B5xdDeOJWuQtA0brCils3iT6DHzPZ6TvuBbEjgnh2vFEg5nqNKUaDR1/G3
	oj71b/AmRwR5W7+kEEfPyLvftF8UUGcxs56+3xtc39MlPycYj3PLXhuG7CTz8/Xq
	Xxj/OUklefNF8Vs+pJXEuY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wC3n+U2c75nv25qOg--.2011S4;
	Wed, 26 Feb 2025 09:49:44 +0800 (CST)
From: yaxin_wang <yaxin_wang_uestc@163.com>
To: corbet@lwn.net
Cc: alexs@kernel.org,
	si.yanteng@linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xu.xin16@zte.com.cn,
	yang.yang29@zte.com.cn,
	wang.yaxin@zte.com.cn,
	fan.yu9@zte.com.cn,
	he.peilin@zte.com.cn,
	tu.qiang35@zte.com.cn,
	qiu.yutan@zte.com.cn,
	zhang.yunkai@zte.com.cn,
	ye.xingchen@zte.com.cn,
	jiang.kun2@zte.com.cn
Subject: Re: [PATCH linux next] Docs/zh_CN: Translate msg_zerocopy.rst to Simplified Chinese
Date: Wed, 26 Feb 2025 01:49:42 +0000
Message-Id: <20250226014942.2586561-1-yaxin_wang_uestc@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3n+U2c75nv25qOg--.2011S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrW7ArW5ZrWrKr1kCFWxZwb_yoW3Jwc_Kw
	4Fyr1Ikr1qqr4IgFWkGFn0gr1Fgw4fJr43Xrs8tF13twn5KFZ5JFn2q3yS9asIgrZFvr4a
	kwn5XrsYkryavjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRzB-tUUUUU==
X-CM-SenderInfo: p1d0x0xbzd0wpbxh23rf6rljoofrz/1tbi7gAAxGe+a7eFXgABs1

><jiang.kun2@zte.com.cn> writes:
>
>> From: Wang Yaxin <wang.yaxin@zte.com.cn>
>>
>> translate the "msg_zerocopy.rst" into Simplified Chinese
>>
>> Update to commit bac2cac12c26("docs: net: description of
>> MSG_ZEROCOPY for AF_VSOCK")
>>
>> Signed-off-by: Wang Yaxin <wang.yaxin@zte.com.cn>
>> Signed-off-by: Jiang Kun <jiang.kun2@zte.com.cn>
>> Reviewed-by: xu xin <xu.xin16@zte.com.cn>
>> Reviewed-by: He Peilin <he.peilin@zte.com.cn>
>
>So how did these reviews happen?  I have certainly not seen them on the
>public lists...
>
>Thanks,
>
>jon

xu xin and he peilin are my colleagues. They helped me with the internal
review of the document and did not participate in the public lists review.

Thanks,

Yaxin


