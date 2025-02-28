Return-Path: <linux-kernel+bounces-538878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FBFA49E30
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6292F3A8564
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4F3191F89;
	Fri, 28 Feb 2025 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="iDXUUpNR"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77F31EF37E;
	Fri, 28 Feb 2025 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740758439; cv=none; b=um3ICPOgJca3jP2d1lz8th7NhhsWGI3tPAi2Mklhux6FyMYZHREAyjmG/utr//OwI8zmI8d1hFqJVNRqB0yGv1W4A8uNTZsHLyoyt3zESb4O2hW7bNTulgc04nArQTPKVeic/bOTard2/k9Quues9p/B5T8KWKQ5zLqq+JarvTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740758439; c=relaxed/simple;
	bh=cgP2s/EHQk8RYIE8hxTnpji7BZLYjtN6szVkZy3cQvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AKddnh3xEV+erjHZrmvgaj0J3jVkt2bZow6AvhUzXoo0FLEG4+riSk9kMRB0w9iVhClrajqZ7dPTlBNmhF0KEcmT3t+qySBw5VEk3iH/ky1nFiRrBpNft6fVn1ej8Ski8LwyMhPVbuFwJ97fZmVUaJgRNojle+kjeWeek7lUcKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=iDXUUpNR; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740758413; x=1741363213; i=markus.elfring@web.de;
	bh=cgP2s/EHQk8RYIE8hxTnpji7BZLYjtN6szVkZy3cQvA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iDXUUpNRIpE92v0ffZo/ZYwLuFULwQZj8y9Iu9JALbogwuFALqm2c3hrENa/L0SB
	 X8Yq3B8cJa7K8USvCzY9W5ZpsZblXddTcY8qRih1I7+VX7W1zcptMjRL5vHii0tJN
	 EcbWHJnmHla88uOAY/7nYJrRqmmle2w0veGn4Te4P3kD5lizM9BCmXeRVpEc+wsiq
	 I2mpyNns+lOwtwlFXHMs0u9ZX6QMQ7jJOmn4sDxraPIi2KfPiIf/vko5OvMGpxRXk
	 JDebBBIUqgxlg8DENCgbHFwEAw9eVVZP293aALPVl8h5FsYSqFfM6oMcq/IEt1lHI
	 9W0VGWYGtViQ40/+EQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.27]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MN6Bb-1tXCDg30I1-00U5Ft; Fri, 28
 Feb 2025 17:00:13 +0100
Message-ID: <18be1b16-fd2f-4b24-a821-c91c3b559ff0@web.de>
Date: Fri, 28 Feb 2025 17:00:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nvme-fc: Simplify minimum determination in two functions
To: Qasim Ijaz <qasdev00@gmail.com>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, James Smart <james.smart@broadcom.com>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org
References: <Z8HY1RX5-SOjYOdx@qasdev.system>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <Z8HY1RX5-SOjYOdx@qasdev.system>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:33vHCRLZ2Nx6E8dU3GxJqWNO1JvkefG+apIROXoRTerGO+K2DwQ
 bhqf+X1k+jqCzj9D0aNQ/R+YCvIuXyQSMu04mdYINCAw7rncgR2bYow8YvYvEbZ1Mr24iv8
 iy91Q4MKXJ4Bw4h+aZwn6NrJsrbaTIRW+ZmQ6wPB6CQGMxVG76ZuydMpa8HUhN+p5OJOx8V
 GFQGwe8ck4vszgQeSTCvA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+4yAa5LsNfY=;8lEVGwcl4u+NYv57TGg5LeppPu3
 3/j8sKTU0JL3zu6QwdjvR3llHlqqxdXTUo8w+hbEyYDl0opJgfEEB7N3RuqTTN3a/JIZTbYO4
 N4VWSyzHOqUSf4oD8nkDDYnry/y76ynkQ8VcSDhjDeGRBsxDaIWkpZguMlGeogwn/LpH8zPOU
 Gx0mS4fT3mc7Ab2KGS3jEsRRJZrsbYfqk+pqIw3oCoAM+TV2Kb+MVk0S7NO7NRWDIDOHnSo1A
 xRYy9eMHct6MGAsmjZspqN9iKC3OawbGmKndDss4FBQ9V5oU26PzZD9OAUEmqQ6gtTLCJakNp
 Ezu0cRIwqHKzLDafRxBZBbLsHEwpexUt6a5Sca3h3WFH1aW2XrE1Mpo12Ri3OiZqP6SkFCb87
 Vn8UWg/wJdG0Uqjjx1LiZnlRd7nIvPVXxDHtL8dDgKFohlBiOfTwViaN3US1kEl1U0pvftEnj
 DG4WCA7Gti6Gk61uWVMoh3+2kY/NAImWM+QrHhQGMQcIMnETcVSRX0l6lhAl1sz9mjuH9Vkpo
 Nm7DrbJvBZvGbpTUB5xnqsYn39PlyXaarEdtgF0XPsXDB2nQ20l3hhbXOvqaAf1EaVsVN/V8a
 s603WK1a5LvNDB80QuhCwk3rb3ylNdVNp1blzOZRPAEXRxgMKpUAA0gTQU6z341fivDebc1WF
 z/6u0ezQ3kG2khLo5zpoGZHrd09Y94EYSJGYprKmEzKFeSLFF0ZxDkCZ9gouUX2o2BKwsZTgK
 weAGzM6qyjhiR7RaM2a/ZQbRHuBZxsQlt9yUvWTr0IfQ21n/8fzm1xO7q6QtEjKD1vILqfqAy
 zlQ6GZwxFv5R0pSAO8xEVakUr9d5Yu1RXRC+VOjuIW4xQGQbAPVucjSe/aArAjMbZynxr6Qcq
 tN39b89iU13NoFLNhjDMtVfTDlwovonzNzxn9G+/uNUay08sAhZm3sxAShaAMJ+D/XyEjiNps
 L0UhiEU2ae/kufI2Mmef4rZw7GNbX3sxDEoNVTMQqgcXDzCNZVYzotEpc4IcwncBx/+unEKvQ
 MzODpDmhokrSUfumobqT1JRM15afIVHrzJDWg1x1AUIX183Z/XWyrSKmET5kOwhz5z/y/T/Xx
 cC7JpuPGnxRRB3LZy5bhgZXaKLZm/MdsOmhNF572O9CPwI5jUa661zyUR9ufDoCaQgkS1E888
 d+o2iF4fkwengXJQqjGhQRlqy7jxm9kilDECvwFNwN+qVolK52Oz9lRmM+u6DSHpgf+ul/I4f
 hDuVpsjYCCzr4+ZM4KgzkhmVy49Hh2Ujg6716go0o36TeG+P6o+VXmyCZqaEh6qc5W5wpkz5g
 ZHcHhkjs6c98XMigLDwX/Ot1hSmf6WgVcEr/u53Wi+POqfoDN1qoL2cVMtC0HtOezBaxhOqos
 4xZdn106AYkR6U8cMpaMMSTPLc09fpaVbETq0jHsRkeR3IaNIbXOOmGSj6Oip1/Ofca+DkqbD
 JDhTlCJSWuVYTD7+cf+gjHYU5ZyM=

> I have already submitted a patch for this twice in the past:

Thanks for the reminder.

I am curious then which change variant will be integrated finally.

Regards,
Markus

